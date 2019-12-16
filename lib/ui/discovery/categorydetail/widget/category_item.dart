import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/bean/catetory_bean_entity.dart';
import 'package:flutter_mvp/res/styles.dart';
import 'package:flutter_mvp/ui/discovery/categorydetail/page/category_detail_page.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(this.mData);

  final CategoryBeanEntity mData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryDetailPage(mData)));
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Hero(
            tag: mData,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: CachedNetworkImage(
                imageUrl: mData.bgPicture,
                height: (MediaQuery.of(context).size.width - 10) / 2,
                width: (MediaQuery.of(context).size.width - 10) / 2,
              ),
            ),
          ),
          Text(
            "# ${mData.name}",
            style: MTextStyles.textBoldWhite16,
          )
        ],
      ),
    );
  }
}
