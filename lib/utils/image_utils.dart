import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class ImageUtils {
  static String getImagePath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static ImageProvider getImageProvider(String imageUrl,
      {String holderImg: "none"}) {
    if (TextUtil.isEmpty(imageUrl)) {
      return AssetImage(getImagePath(holderImg));
    }
    return CachedNetworkImageProvider(imageUrl);
  }
}
