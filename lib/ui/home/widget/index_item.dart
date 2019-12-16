import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/ui/detail/page/video_detail_page.dart';
import 'package:flutter_mvp/utils/image_loader.dart';
import 'package:flutter_mvp/utils/time_format_util.dart';

class HomeItem extends StatelessWidget {
  final HomeItemIssuelistItemlist mData;
  final AnimationController animationController;
  final Animation animation;

  const HomeItem(this.mData,
      {Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mData == null) {
      return Container();
    }
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 100 * (1.0 - animation.value), 0.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            VideoDetailPage(playData: mData)));
              },
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: mData.data,
                    child: AspectRatio(
                      aspectRatio: 16.0 / 9.0,
                      child: ImageLoader.loadDefault(
                          mData.data.cover.feed ?? mData.data.cover.detail),
                    ),
                  ),
                  Container(
                    color: MColors.white,
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: Image.network(mData.data.author.icon,
                              height: 40.0, width: 40.0),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0),
                            height: 40.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  mData.data.title,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: MColors.text_dark, fontSize: 14.0),
                                ),
                                Text(
                                  _buildTags(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: MColors.text_gray, fontSize: 12.0),
                                )
                              ],
                            ),
                          ),
                        ),
                        Center(
                            child: Text(
                          "#" + mData.data.category,
                          style: TextStyle(
                              color: MColors.text_gray, fontSize: 12.0),
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///构建tags
  String _buildTags() {
    var mTags = "#";
    if (mData != null && mData.data != null && mData.data.tags != null) {
      List<HomeItemIssuelistItemlistDataTag> tags =
          mData.data.tags.where((item) => item.name.isNotEmpty).toList();
      for (int i = 0; i < tags.length; i++) {
        mTags += tags[i].name + "/";
      }
    }
    mTags += TimeFormatUtil.durationFormat(mData.data.duration);
    return mTags;
  }
}
