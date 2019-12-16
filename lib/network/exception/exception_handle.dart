import 'dart:io';

import 'package:dio/dio.dart';

import 'error_status.dart';

class ExceptionHandle {
  static NetError handleException(dynamic error) {
    print(error);
    if (error is DioError) {
      if (error.type == DioErrorType.DEFAULT ||
          error.type == DioErrorType.RESPONSE) {
        dynamic e = error.error;

        ///网络异常
        if (e is SocketException) {
          return NetError(ErrorStatus.SOCKET_ERROR, "网络异常，请检查网络...");
        }

        ///服务器异常
        if (e is HttpException) {
          return NetError(ErrorStatus.SERVER_ERROR, "服务器异常...");
        }
        //默认返回网络异常
        return NetError(ErrorStatus.NETWORK_ERROR, "网络异常，请检查网络...");

        ///各种超时
      } else if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.SEND_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT) {
        return NetError(ErrorStatus.TIMEOUT_ERROR, "连接超时...");

        ///取消请求操作
      } else if (error.type == DioErrorType.CANCEL) {
        return NetError(ErrorStatus.CANCEL_ERROR, "");

        //其他异常
      } else {
        return NetError(ErrorStatus.UNKNOWN_ERROR, "未知异常...");
      }
    } else {
      return NetError(ErrorStatus.UNKNOWN_ERROR, "未知异常...");
    }
  }
}

class NetError {
  int code;
  String msg;

  NetError(this.code, this.msg);
}
