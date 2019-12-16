
import 'package:flutter_mvp/common/constant.dart';

import '../entity_factory.dart';


///数据解析的基础类
class BaseResponse<T> {
  int code;
  String message;
  T data;
  List<T> listData = [];

  BaseResponse(this.code, this.message, this.data);

  BaseResponse.fromJson(Map<String, dynamic> json) {
    code = json[Constant.code];
    message = json[Constant.message];
    if (json.containsKey(Constant.data)) {
      if (json[Constant.data] is List) {
        (json[Constant.data] as List).forEach((item) {
          if (T.toString() == "String") {
            listData.add(item.toString() as T);
          } else {
            listData.add(EntityFactory.generateOBJ<T>(item));
          }
        });
      } else {
        if (T.toString() == "String") {
          data = json[Constant.data].toString() as T;
        } else if (T.toString() == "Map<dynamic, dynamic>") {
          data = json[Constant.data] as T;
        } else {
          data = EntityFactory.generateOBJ(json[Constant.data]);
        }
      }
    }
  }

}