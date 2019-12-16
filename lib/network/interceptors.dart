import 'package:dio/dio.dart';
import 'package:flutter_mvp/utils/log_utils.dart';

import 'exception/error_status.dart';
import 'package:sprintf/sprintf.dart';

///头部管理拦截器
class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    options.headers["Accept"] = "application/json";
    options.headers["User-Agent"] = "insomnia/6.4.1";
    return super.onRequest(options);
  }
}

///日志拦截器设置
class LoggingInterceptor extends Interceptor {
  DateTime startTime;
  DateTime endTime;

  @override
  onRequest(RequestOptions options) {
    startTime = DateTime.now();
    Log.d("----------Request Start---------");

    ///用于拼接打印出请求的全路径
    if (options.queryParameters.isEmpty) {
      if(options.path.contains(options.baseUrl)){
        Log.i("RequestUrl:" +options.path);
      }else{
      Log.i("RequestUrl:" + options.baseUrl + options.path);
      }
    } else {
      ///如果queryParameters 不为空则拼接成完整的URl
      Log.i("RequestUrl:" +
          options.baseUrl +
          options.path +
          "?" +
          Transformer.urlEncodeMap(options.queryParameters));
    }
    Log.d("RequestMethod:" + options.method);
    Log.d("RequestHeaders:" + options.headers.toString());
    Log.d("RequestContentType:" + options.contentType.toString());
    Log.d("RequestData:${options.data.toString()}");

    return super.onRequest(options);
  }

  @override
  onResponse(Response response) {
    endTime = DateTime.now();
    //请求时长
    int duration = endTime.difference(startTime).inMilliseconds;
    Log.d("----------End 共用 $duration 毫秒---------");
//    Log.d(response.data);
    return super.onResponse(response);
  }

  @override
  onError(DioError err) {
    Log.d("--------------Error-----------");
    return super.onError(err);
  }
}

//解析数据的拦截器
class AdapterInterceptor extends Interceptor {
  static const String MSG = "msg";
  static const String SLASH = "\"";
  static const String MESSAGE = "message";
  static const String ERROR = "validateError";

  static const String DEFAULT = "\"无返回信息\"";
  static const String NOT_FOUND = "未查询到信息";

  static const String FAILURE_FORMAT = "{\"code\":%d,\"message\":\"%s\"}";
  static const String SUCCESS_FORMAT =
      "{\"code\":0,\"data\":%s,\"message\":\"\"}";

  @override
  onResponse(Response response) {
    Response rp=adapterData(response);
    return super.onResponse(rp);
  }

  @override
  onError(DioError err) {
    if(err.response!=null){
    adapterData(err.response);
    }
    return super.onError(err);
  }

  Response adapterData(Response response) {
    String result;
    String content = response.data == null ? "" : response.data.toString();
    if (response.statusCode == ErrorStatus.SUCCESS) {
      if (content.isEmpty) {
        content = DEFAULT;
      }
      result = sprintf(SUCCESS_FORMAT, [content]);
      response.statusCode = ErrorStatus.SUCCESS;
    } else {
      result = sprintf(FAILURE_FORMAT, [response.statusCode, NOT_FOUND]);
      response.statusCode = ErrorStatus.SUCCESS;
    }
    if (response.statusCode == ErrorStatus.SUCCESS) {
      Log.d("ResponseCode:${response.statusCode}");
    } else {
      Log.e("ResponseCode:${response.statusCode}");
    }
    Log.json(result);
    response.data = result;
    return response;
  }
}
