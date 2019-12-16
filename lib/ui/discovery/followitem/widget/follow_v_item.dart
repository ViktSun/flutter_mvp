import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/ui/discovery/followitem/widget/author_info_item.dart';

import 'follow_h_item.dart';

class FollowVItem extends StatelessWidget {
  FollowVItem(this.mData);

  final HomeItemIssuelistItemlist mData;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.0),
      child: Column(
        children: <Widget>[
          //作者信息
          Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
            child: AuthorInfoItem(mData),
          ),
          Container(
            height: 251.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3.0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mData.data.itemList.length,
                  itemBuilder: (_, index) {
                    return FollowHItem(mData.data.itemList[index]);
                  }),
            ),
          ),
          Container(height: 1.0, color: MColors.white_dd,)
        ],
      ),
    );
  }
}
