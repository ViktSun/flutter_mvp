
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
class ColorTransUtil{

  ///
  /// 根据比例，在两个color值之间计算出一个color值
  ///<b>注意该方法是ARGB通道分开计算比例的</b>
  ///
  /// @param fromColor 开始的color值
  /// @param toColor   最终的color值
  /// @param fraction  比例，取值为[0,1]，为0时返回 fromColor， 为1时返回 toColor
  /// @return 计算出的color值
   static Color computeColor(Color fromColor, Color toColor, double fraction) {

    fraction = math.max(math.min(fraction, 1), 0);

    int minColorA = fromColor.alpha;
    int maxColorA = toColor.alpha;
    int resultA =  (((maxColorA - minColorA) * fraction) + minColorA).toInt();

    int minColorR = fromColor.red;
    int maxColorR = toColor.red;
    int resultR = (((maxColorR - minColorR) * fraction) + minColorR).toInt();

    int minColorG = fromColor.green;
    int maxColorG = toColor.green;
    int resultG =  (((maxColorG - minColorG) * fraction) + minColorG).toInt();

    int minColorB = fromColor.blue;
    int maxColorB = toColor.blue;
    int resultB =  (((maxColorB - minColorB) * fraction) + minColorB).toInt();

    return Color.fromARGB(resultA, resultR, resultG, resultB);
  }

}