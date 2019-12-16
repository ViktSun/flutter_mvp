
///管理错误码的状态
class ErrorStatus{

  //数据成功的Code
  static const int REQUEST_DATA_OK = 0;

  //请求成功
  static const int SUCCESS = 200;

  //服务器拒绝访问
  static const int FORBIDDEN = 403;

  static const int NOT_FOUND = 404;

  //其他错误
  static const int UNKNOWN_ERROR =1000;

  //网络异常
  static const int NETWORK_ERROR = 1001;

  //服务器连接错误
  static const int SOCKET_ERROR = 1002;

  //服务器内部错误
  static const int SERVER_ERROR = 1003;

  //连接超时
  static const int TIMEOUT_ERROR = 1004;

  //网络请求取消
  static const int CANCEL_ERROR = 1005;

  //数据转对象错误
  static const int PARSE_ERROR = 1006;
}