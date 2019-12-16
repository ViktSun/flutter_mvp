import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/event/video_detail_event.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/res/dimens.dart';
import 'package:flutter_mvp/res/gaps.dart';
import 'package:flutter_mvp/res/styles.dart';
import 'package:flutter_mvp/utils/global_event_bus.dart';
import 'package:flutter_mvp/utils/time_format_util.dart';

class VideoSmallCard extends StatelessWidget {
  VideoSmallCard(this.mData);

  final HomeItemIssuelistItemlist mData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Container(
              width: double.infinity,
              color: Colors.transparent,
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: CachedNetworkImage(
                      width: 135.0,
                      height: 80.0,
                      fit: BoxFit.fill,
                      imageUrl: mData.data.cover.detail,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: Dimens.gap_dp10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            mData.data.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: MTextStyles.textWhite12,
                          ),
                          Gaps.vGap12,
                          Text(
                            "#${mData.data.category}/${TimeFormatUtil.durationFormat(mData.data.duration)}",
                            style: MTextStyles.textWhiteDD12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          onTap: (){
            var data = VideoDetailEvent(mData);
            GlobalEventBus().eventBus.fire(data);
//            Navigator.pushReplacement(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => VideoDetailPage(playData:mData)));
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          color: MColors.white_line,
          height: 0.5,
        ),
      ],
    );
  }
}
