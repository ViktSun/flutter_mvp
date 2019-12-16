class Constant{
  ///debug的开关，由于控制上限的需要关闭的业务
  ///App运行Release时候,inProduction为true; 为Debug的时候为false
  static const bool inProduction = const bool.fromEnvironment("dart.vm.product");


  static const String data = "data";
  static const String message = "message";
  static const String code = "code";
}