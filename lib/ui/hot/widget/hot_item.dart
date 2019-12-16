import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/res/gaps.dart';
import 'package:flutter_mvp/res/styles.dart';
import 'package:flutter_mvp/ui/detail/page/video_detail_page.dart';
import 'package:flutter_mvp/utils/time_format_util.dart';

class HotItem extends StatelessWidget {
  HotItem(this.mData);

  final HomeItemIssuelistItemlist mData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Hero(
              tag: mData.data,
              child: CachedNetworkImage(
                imageUrl: mData.data.cover.feed,
                height: 250.0,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              color: MColors.dart_light_color,
              height: 250.0,
            ),
            Column(
              children: <Widget>[
                Text(
                  mData.data.title,
                  style: MTextStyles.textBoldWhite14,
                ),
                Gaps.vGap5,
                Text(
                    "#${mData.data.category}/${TimeFormatUtil.durationFormat
                      (mData.data.duration)}",style: MTextStyles.textWhite12,)
              ],
            ),
          ],
        ),
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoDetailPage(playData: mData)));
        },
      ),
    );
  }
}
