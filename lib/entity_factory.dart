import 'package:flutter_mvp/bean/hot_bean_entity.dart';
import 'package:flutter_mvp/bean/header_bean_entity.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/bean/catetory_bean_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "HotBeanEntity") {
      return HotBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "HeaderBeanEntity") {
      return HeaderBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeBeanEntity") {
      return HomeBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "CategoryBeanEntity") {
      return CategoryBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeItemIssuelist") {
      return HomeItemIssuelist.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
