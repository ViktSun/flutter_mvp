import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/res/gaps.dart';
import 'package:flutter_mvp/res/styles.dart';

///关注的列表
class AuthorInfoItem extends StatelessWidget {
  AuthorInfoItem(this.mData);

  final HomeItemIssuelistItemlist mData;

  @override
  Widget build(BuildContext context) {
    ///如果作者的信息为null 则返回空的，否则返回作者信息
    return mData.data.author == null
        ? Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: mData.data.header.icon,
                    height: 40.0,
                    width: 40.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          mData.data.header.title,
                          style: MTextStyles.textDark14,
                        ),
                        Gaps.vGap5,
                        Text(
                          mData.data.header.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: MTextStyles.textDark12,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 6.0, top: 2.0, right: 6.0, bottom: 2.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  child: Text(
                    "+ 关注",
                    style: MTextStyles.textDark12,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
