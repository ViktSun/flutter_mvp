import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvp/utils/image_utils.dart';

class ImageLoader {
  static CachedNetworkImage loadDefault(String url, {BoxFit fit: BoxFit.fill,
    double height:double.infinity,double width:double.infinity}) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
//      placeholder: (context, url) => Image.asset(
//        ImageUtils.getImagePath("default_avatar"),
//        fit:BoxFit.none,
//      ),
//      errorWidget: (context, url, error) => Image.asset(
//        ImageUtils.getImagePath("default_avatar"),
//        fit:BoxFit.none,
//      ),
    );
  }


  static CachedNetworkImage loadNoPlaceHolder(String url, {BoxFit fit: BoxFit.fill,
    double height:double.infinity,double width:double.infinity}) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
