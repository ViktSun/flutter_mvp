import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/ui/detail/page/video_detail_page.dart';
import 'package:flutter_mvp/utils/image_loader.dart';

class HomeBanner extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final List<HomeItemIssuelistItemlist> bannerData;

  const HomeBanner(this.bannerData, {Key key,this.animationController,this.animation}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var ratioHeight = MediaQuery.of(context).size.width * 9.0 / 16.0;
    var statusBarHeight = MediaQuery.of(context).padding.top;

    if (bannerData == null || bannerData.isEmpty) {
      return Container();
    }
    return AnimatedBuilder(
      animation: animationController,
      builder: (context,child){
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(0.0,100*(1.0-animation
                .value), 0.0),
            child: Container(
              ///轮播图的高度
              height: ratioHeight + statusBarHeight,
              child: Swiper(
                  circular: true,
                  indicatorAlignment: AlignmentDirectional.bottomEnd,
                  indicator: CircleSwiperIndicator(
                      itemColor: Colors.white60, itemActiveColor: Colors.white),
                  interval: const Duration(seconds: 3),
                  children:
                  bannerData.where((item) => item.data.cover != null).map((model) {
                    if (model != null &&
                        model.data != null &&
                        model.data.cover != null) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VideoDetailPage(playData: model)));
                        },
                        child: Hero(
                          tag: model.data,
                          child: Material(
                            child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: <Widget>[
                                ImageLoader.loadDefault(
                                    model.data.cover.feed ?? model.data.cover.detail),
                                Container(
                                  padding: EdgeInsets.only(left: 6.0),
                                  alignment: Alignment.centerLeft,
                                  color: MColors.trans_banner_bg,
                                  height: 32.0,
                                  child: Text(
                                    model.data.title,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: MColors.trans_banner_text),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }).toList()),
            ),
          ),
        );
      },
    );
  }
}
