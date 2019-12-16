import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/res/gaps.dart';
import 'package:flutter_mvp/res/styles.dart';
import 'package:flutter_mvp/utils/image_utils.dart';
import 'package:flutter_mvp/utils/time_format_util.dart';

class VideoInfoItem extends StatelessWidget {
  VideoInfoItem(this.mData);

  final HomeItemIssuelistItemlist mData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(15.0),
          color: MColors.dark_44,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                mData.data.title,
                style: MTextStyles.textBoldDD14,
              ),
              Gaps.vGap10,
              Text(
                "#${mData.data.category} / ${TimeFormatUtil.durationFormat(mData.data.duration)}",
                style: MTextStyles.textWhiteDD12,
              ),
              Gaps.vGap10,
              Text(
                mData.data.description,
                style: MTextStyles.textWhiteDD12,
              ),
              Gaps.vGap16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Center(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          ImageUtils.getImagePath("ic_action_favorites"),
                          width: 20.0,
                          height: 20.0,
                        ),
                        Gaps.hGap5,
                        Text(
                          mData.data.consumption.collectionCount.toString(),
                          style: MTextStyles.textWhiteDD12,
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      child: Center(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          ImageUtils.getImagePath("ic_action_share"),
                          width: 20.0,
                          height: 20.0,
                        ),
                        Gaps.hGap5,
                        Text(
                          mData.data.consumption.shareCount.toString(),
                          style: MTextStyles.textWhiteDD12,
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      child: Center(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          ImageUtils.getImagePath("ic_action_reply"),
                          width: 20.0,
                          height: 20.0,
                        ),
                        Gaps.hGap5,
                        Text(
                          mData.data.consumption.replyCount.toString(),
                          style: MTextStyles.textWhiteDD12,
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      child: Center(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          ImageUtils.getImagePath("ic_action_offline"),
                          width: 20.0,
                          height: 20.0,
                        ),
                        Gaps.hGap5,
                        const Text(
                          "缓存",
                          style: MTextStyles.textWhiteDD12,
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
        Column(
          ///顶部线条
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 0.5,
              color: MColors.white_line,
            ),
            ///作者相关内容
            Container(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: 40.0,
                      height: 40.0,
                      imageUrl: mData.data.author.icon,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        child: mData.data.author != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    mData.data.author.name,
                                    style: MTextStyles.textWhite14,
                                  ),
                                  Gaps.vGap5,
                                  Text(
                                    mData.data.author.description,
                                    style: MTextStyles.textWhiteDD12,
                                  )
                                ],
                              )
                            : Container(),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          left: 6.0, top: 2.0, bottom: 2.0, right: 6.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: MColors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Text(
                        "+ 关注",
                        style: MTextStyles.textWhite12,
                      )),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: MColors.white_line,
            ),
          ],
        ),
      ],
    );
  }
}
