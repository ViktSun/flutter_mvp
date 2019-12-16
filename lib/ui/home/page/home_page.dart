import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/view/base_state.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/ui/home/widget/index_banner.dart';
import 'package:flutter_mvp/ui/home/widget/index_header.dart';
import 'package:flutter_mvp/ui/home/widget/index_item.dart';
import 'package:flutter_mvp/ui/home/widget/index_search_bar.dart';
import 'package:flutter_mvp/widgets/my_refresh_list.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';
import 'package:provider/provider.dart';

import '../prsenter/home_presenter.dart';
import '../provider/home_provider.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends BaseState<HomePage, HomePresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  HomeProvider<HomeItemIssuelistItemlist> provider =
      HomeProvider<HomeItemIssuelistItemlist>();
  AnimationController animationController;
  double opacity = 0.0;

  //滚动监听器
  ScrollController _controller = ScrollController();

  //是否展示顶部标题
  bool showTopTitle = false;

  @override
  void initState() {
    provider.setStateTypeNotify(StateType.loading);
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    super.initState();
    _refresh();
//    _controller.addListener(() {
//      if (_controller.offset < 200 && showTopTitle) {
//        setState(() {
//          showTopTitle = false;
//        });
//      } else if (_controller.offset >= 200 && showTopTitle == false) {
//        setState(() {
//          showTopTitle = true;
//        });
//      }
//    });
  }

  @override
  void dispose() {
    animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<HomeProvider<HomeItemIssuelistItemlist>>(
      builder: (_) => provider,
      child: Consumer<HomeProvider<HomeItemIssuelistItemlist>>(
        builder: (context, provider, _) {
          return Stack(
            children: <Widget>[
              RefreshList(
                padding: EdgeInsets.only(top: 0),
                itemCount: provider.list.length,
                stateType: provider.stateType,
                indicatorFrontColor: MColors.white,
                indicatorBackgroundColor: MColors.transparent_60,
                onRefresh: _refresh,
                loadMore: _loadMore,
                hasMore: provider.hasMore,
                scrollController: _controller,
                itemBuilder: (context, index) {
                  //为每个Item 创建
                  var itemAnimation = Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / 4) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController.forward();
                  if (provider.list[index].type == "banner") {
                    return HomeBanner(
                      provider.banners,
                      animation: itemAnimation,
                      animationController: animationController,
                    );
                  } else if (provider.list[index].type == "textHeader") {
                    return HomeItemTitle(
                      provider.list[index].data.text,
                      animation: itemAnimation,
                      animationController: animationController,
                    );
                  } else {
                    return HomeItem(
                      provider.list[index],
                      animationController: animationController,
                      animation: itemAnimation,
                    );
                  }
                },
              ),
              HomeSearchBar(showTopTitle, "2019-11"),
            ],
          );
        },
      ),
    );
  }

  Future<void> _refresh() async {
    await mPresenter.refreshHomeData();
  }

  Future _loadMore() async {
    await mPresenter.getHomeMoreData(provider.nextPageUrl);
  }

  @override
  HomePresenter createPresenter() {
    return HomePresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
