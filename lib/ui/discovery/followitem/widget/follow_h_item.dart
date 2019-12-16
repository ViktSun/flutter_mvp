import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/res/styles.dart';
import 'package:flutter_mvp/ui/detail/page/video_detail_page.dart';
import 'package:flutter_mvp/utils/time_format_util.dart';

///关注的横向滚动的列表
class FollowHItem extends StatelessWidget {
  FollowHItem(this.mData);

  final HomeItemIssuelistItemlist mData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(right: 10.0, bottom: 0.0),
        child: Column(
          children: <Widget>[
            //图片
            Hero(
              tag: mData.data,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: CachedNetworkImage(
                  height: 200.0,
                  width: 300.0,
                  fit: BoxFit.fill,
                  imageUrl: mData.data.cover.feed,
                ),
              ),
            ),
            Container(
              width: 300.0,
              padding: EdgeInsets.only(top: 6.0, left: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    mData.data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: MTextStyles.textDark14,),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      "# ${mData.data.category} / ${TimeFormatUtil.durationFormat(mData.data.duration)}"
                      ,style: MTextStyles
                        .textDark12,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoDetailPage(playData: mData)));
      },
    );
  }
}
