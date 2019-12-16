import 'package:dio/dio.dart';
import 'package:flutter_mvp/network/exception/error_status.dart';
import 'package:flutter_mvp/network/network_util.dart';

import '../view/i_base_view.dart';
import 'i_presenter.dart';

class BasePresenter<V extends IBaseView> extends IPresenter {
  V view;

  //取消网络请求
  CancelToken _cancelToken;

  BasePresenter() {
    _cancelToken = CancelToken();
  }

  @override
  void deactivate() {}

  @override
  void didChangeDependencies() {}

  @override
  void didUpdateWidget<W>(W oldWidget) {}

  @override
  void dispose() {
    if (_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  @override
  void initState() {}

  Future requestFutureData<T>(Method method,
      {String url,
      bool isShow: true,
      bool isClose: true,
      Function(T t) onSuccess,
      Function(List<T> list) onSuccessList,
      Function(int code, String msg) onError,
      dynamic params,
      Map<String, dynamic> queryParams,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) async {
    if (isShow) {
      view.showProgress();
    }
    await DioUtils.instance.requestDataFuture<T>(method, url,
        params: params,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken ?? _cancelToken, onSuccess: (data) {
      if (isClose) view.closeProgress();
      if (onSuccess != null) {
        onSuccess(data);
      }
    }, onSuccessList: (data) {
      if (isClose) view.closeProgress();
      if (onSuccessList != null) onSuccessList(data);
    }, onError: (code, msg) {
      _onError(code, msg, onError);
    });
  }

  void requestDataFromNetwork<T>(Method method,
      {String url,
      bool isShow: true,
      bool isClose: true,
      Function(T t) onSuccess,
      Function(List<T> list) onSuccessList,
      Function(int code, String msg) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) {
    ///展示加载圈
    if (isShow) view.showProgress();
    DioUtils.instance.requestData<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
        isList: isList, onSuccess: (data) {
      ///请求数据成功
      if (isClose) view.closeProgress();
      if (onSuccess != null) {
        onSuccess(data);
      }

      ///请求列表成功
    }, onSuccessList: (data) {
      if (isClose) view.closeProgress();
      if (onSuccessList != null) {
        onSuccessList(data);
      }

      ///请求错误
    }, onError: (code, msg) {
      _onError(code, msg, onError);
    });
  }

  _onError(int code, String msg, Function(int code, String msg) onError) {
    view.closeProgress();
    if (code != ErrorStatus.CANCEL_ERROR) {
      view.showToast(msg);
    }

    if (onError != null && view.getContext() != null) {
      onError(code, msg);
    }
  }
}
