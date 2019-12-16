import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvp/network/interceptors.dart';
import 'package:flutter_mvp/utils/log_utils.dart';
import 'package:flutter_mvp/utils/toast.dart';

import 'api/network_api.dart';
import 'exception/error_status.dart';
import 'exception/exception_handle.dart';
import 'net_response.dart';
import 'package:rxdart/rxdart.dart';

//设置默认的Header 不配置User-Agent 开眼API 403
Map<String, dynamic> headers = {
  "Accept": "application/json",
  "User-Agent": "insomnia/6.4.1"
//  "Content-Type":"application/x-www-form-urlencoded",
};

class DioUtils {
  static final DioUtils _singleInstance = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils() {
    return _singleInstance;
  }

  static Dio _dio;
  BaseOptions _options;

  Dio getDio() {
    return _dio;
  }

  DioUtils._internal() {
    _options = BaseOptions(
      baseUrl: Api.baseUrl,
      connectTimeout: 10000,

      ///响应流前后两次接收数据的间隔
      receiveTimeout: 3000,

      ///如果返回的是json(content-type),dio默认自动转成json,无需手动转
      ///(https://github.com/flutterchina/dio/issues/30)
      responseType: ResponseType.plain,

      //默认的headers 配置
      headers: headers,

      validateStatus: (status) {
        //是否使用http状态码进行判断，为true 表示不使用http状态码判断
        return true;
      },
    );
    _dio = Dio(_options);

    //添加cookie拦截器管理
//    _dio.interceptors.add(CookieManager(CookieJar()));

    //统一请求头拦截器
    _dio.interceptors.add(AuthInterceptor());

    //网络日志拦截器
    _dio.interceptors.add(LoggingInterceptor());

    _dio.interceptors.add(AdapterInterceptor());
  }

  ///将返回的数据进行统一处理并解析成对应的Bean
  Future<BaseResponse<T>> _request<T>(String method, String url,
      {Map<String, dynamic> data,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options}) async {
    var response = await _dio.request(url,
        data: data,
        queryParameters: queryParameters,
        options: _setOptions(method, options),
        cancelToken: cancelToken);
    try {
      Map<String, dynamic> _map =
          await compute(parseData, response.data.toString());
      return BaseResponse.fromJson(_map);
    } catch (e) {
      print(e);
      return BaseResponse(ErrorStatus.PARSE_ERROR, "数据解析异常", null);
    }
  }

  Future requestDataFuture<T>(Method method, String url,
      {Function(T t) onSuccess,
      Function(List<T> list) onSuccessList,
      Function(int code, String msg) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) async {
    String requestMethod = _getMethod(method);

    return await _request<T>(requestMethod, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken)
        .then((BaseResponse<T> result) {
      if (result.code == ErrorStatus.REQUEST_DATA_OK) {
        if (isList) {
          if (onSuccessList != null) {
            onSuccessList(result.listData);
          }
        } else {
          if (onSuccess != null) {
            onSuccess(result.data);
          }
        }
      } else {
        _onError(result.code, result.message, onError);
      }
    }, onError: (e) {
      _cancelLog(e, url);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  BaseResponse parseError() {
    return BaseResponse(ErrorStatus.PARSE_ERROR, "数据解析错误", null);
  }

  ///用于配置Options
  Options _setOptions(String method, Options options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  ///请求单个对象的操作
  Future<BaseResponse<T>> request<T>(String method, String url,
      {Map<String, dynamic> params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options}) async {
    var response = await _request<T>(method, url,
        data: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken);
    return response;
  }

  requestData<T>(Method method, String url,
      {Function(T t) onSuccess,
      Function(List<T> t) onSuccessList,
      Function(int code, String msg) onError,
      Map<String, dynamic> params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) {
    String requestMethod = _getMethod(method);
    Observable.fromFuture(_request<T>(requestMethod, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken))
        .asBroadcastStream()
        .listen((result) {
      //返回的成功的数据
      if (result.code == ErrorStatus.REQUEST_DATA_OK) {
        if (isList) {
          if (onSuccessList != null) {
            onSuccessList(result.listData);
          }
        } else {
          if (onSuccess != null) {
            onSuccess(result.data);
          }
        }
      } else {
        _onError(result.code, result.message, onError);
      }
    }, onError: (e) {
      _cancelLog(e, url);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  _cancelLog(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      Log.i("取消网络请求：$url");
    }
  }

  _onError(int code, String msg, Function(int code, String msg) onError) {
    Log.e("接口请求异常 code:$code message:$msg");
    if (onError != null) {
      onError(code, msg);
    }
    Toast.show(msg);
  }

  //用于获取当前的请求类型
  String _getMethod(Method method) {
    String netMethod;
    switch (method) {
      case Method.get:
        netMethod = "GET";
        break;
      case Method.post:
        netMethod = "POST";
        break;
      case Method.put:
        netMethod = "PUT";
        break;
      case Method.delete:
        netMethod = "DELETE";
        break;
    }
    return netMethod;
  }
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data);
}

enum Method {
  get,
  post,
  put,
  delete,
}
