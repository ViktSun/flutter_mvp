import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/res/styles.dart';
import 'package:flutter_mvp/utils/image_utils.dart';

class DetailCatName extends StatelessWidget {
  DetailCatName(this.data);

  final HomeItemIssuelistItemlist data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          height: 40.0,
          width: double.infinity,
          padding: EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Text(
          data.data.text,
            style: MTextStyles.textWhite12,
          ),
          Image.asset(ImageUtils.getImagePath("ic_action_more_arrow"))
          ],
        ),),
      ],
    );
  }
}
