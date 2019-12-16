import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/provider/base_list_provider.dart';
import 'package:flutter_mvp/base/view/base_state.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/event/video_detail_event.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/ui/detail/presenter/detail_presenter.dart';
import 'package:flutter_mvp/ui/detail/widget/item_video_detail_info.dart';
import 'package:flutter_mvp/ui/detail/widget/item_video_small_card.dart';
import 'package:flutter_mvp/ui/detail/widget/item_video_title_card.dart';
import 'package:flutter_mvp/utils/global_event_bus.dart';
import 'package:flutter_mvp/utils/image_loader.dart';
import 'package:flutter_mvideo_plugin/flutter_mvideo_plugin.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class VideoDetailPage extends StatefulWidget {
  HomeItemIssuelistItemlist playData;

  VideoDetailPage({Key key, @required this.playData});

  @override
  VideoDetailPageState createState() => VideoDetailPageState();
}

class VideoDetailPageState extends BaseState<VideoDetailPage, DetailPresenter>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  ScrollController _controller;

  StreamSubscription _subscription;

  bool isShowVideo = false;

  BaseListProvider<HomeItemIssuelistItemlist> provider =
      BaseListProvider<HomeItemIssuelistItemlist>();

  MVideoPlayerController mVideoController;
  MVideoPlayer videoPlayer;

  var heroTag;

  void _initSplash() {
    _subscription =
        Observable.just(1).delay(Duration(milliseconds: 300)).listen((_) {
      _initVideoPlayer();
      setState(() {
        isShowVideo = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    heroTag = widget.playData.data;
    _controller = ScrollController();
    _setPlayInfo();
    _getRelatedVideo();
    _initSplash();
//    _initVideoPlayer();
    WidgetsBinding.instance.addObserver(this);

    //当点击推荐的相关视频时候刷新页面
    GlobalEventBus().eventBus.on<VideoDetailEvent>().listen((event) {
      this.widget.playData = event.playData;
      _setPlayInfo();
      _getRelatedVideo();
      this.mVideoController.loadUrl(
          widget.playData.data.playUrl, widget.playData.data.cover.feed);
      _controller.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var imgHeight = MediaQuery.of(context).size.width * 9.0 / 16.0;
    var barHeight = MediaQuery.of(context).padding.top;
    return WillPopScope(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            ///使用Hero使页面切换的时候显得更流畅
            Hero(
              tag: heroTag,
              child: Container(
                padding: EdgeInsets.only(top: 0.0),
                height: imgHeight + barHeight,
                child: Stack(
                  children: <Widget>[
                    ImageLoader.loadNoPlaceHolder(
                        widget.playData.data.cover.feed),

                    ///加入淡入淡出效果减缓加载视屏时候的闪烁效果
                    AnimatedOpacity(
                      opacity: isShowVideo ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeOut,

                      ///将statusBar背景设为黑色，并且和视屏组合起来
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).padding.top,
                            color: Colors.black,
                          ),
                          Container(height: imgHeight, child: videoPlayer),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ChangeNotifierProvider<
                  BaseListProvider<HomeItemIssuelistItemlist>>(
                builder: (_) => provider,
                child: Consumer<BaseListProvider<HomeItemIssuelistItemlist>>(
                  builder: (context, provider, _) {
                    return Stack(
                      children: <Widget>[
                        ImageLoader.loadNoPlaceHolder(
                            widget.playData.data.cover.blurred,
                            fit: BoxFit.none),
                        Container(
                          color: MColors.dart_light_color,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        ListView.builder(
                            controller: _controller,
                            padding: EdgeInsets.only(top: 0.0),
                            itemCount: provider.list.length,
                            itemBuilder: (context, index) {
                              var item = provider.list[index];
                              var itemType = item.data.dataType;
                              if (itemType == "VideoBeanForInfo") {
                                return VideoInfoItem(item);
                              } else if (itemType == "TextCard") {
                                return DetailCatName(item);
                              } else if (itemType == "VideoBeanForClient") {
                                return VideoSmallCard(item);
                              } else {
                                return Container();
                              }
                            }),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      onWillPop: () {
        return mVideoController.quitFullScreen();
      },
    );
  }

  void _initVideoPlayer() {
    var x = 0.0;
    var y = 0.0;
    var width = MediaQuery.of(context).size.width;
    var height = width * 9.0 / 16.0;
//    var height = 250.0;
    videoPlayer = MVideoPlayer(
      onCreated: _createPlayerView,
      x: x,
      y: y,
      width: width,
      height: height,
    );
  }

  void _getRelatedVideo() {
    mPresenter.requestRelatedVideo(widget.playData.data.id.toString());
  }

  void _createPlayerView(MVideoPlayerController videoController) {
    this.mVideoController = videoController;
    this
        .mVideoController
        .loadUrl(widget.playData.data.playUrl, widget.playData.data.cover.feed);
  }

  @override
  DetailPresenter createPresenter() {
    return DetailPresenter();
  }

  @override
  bool get wantKeepAlive => true;

  void _setPlayInfo() {
    provider.list.clear();
    widget.playData.data.dataType = "VideoBeanForInfo";
    provider.list.add(widget.playData);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //用于将页面状态变化的时候 更改当前播放状态
    switch (state) {
      case AppLifecycleState.resumed: //在前台可见
        mVideoController.onResume();
        break;
      case AppLifecycleState.paused: //不可见
        mVideoController.onPause();
        break;
      case AppLifecycleState.detached: // 申请暂时暂停
        break;
      case AppLifecycleState.inactive: //可能在任何时候暂停
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _subscription.cancel();
    super.dispose();
  }
}
