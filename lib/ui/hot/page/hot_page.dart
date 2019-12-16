import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/provider/base_list_provider.dart';
import 'package:flutter_mvp/base/view/base_state.dart';
import 'package:flutter_mvp/bean/hot_bean_entity.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/res/styles.dart';
import 'package:flutter_mvp/ui/hot/page/hot_list_page.dart';
import 'package:flutter_mvp/ui/hot/presenter/hot_presenter.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class HotPage extends StatefulWidget {
  @override
  HotPageState createState() => HotPageState();
}

class HotPageState extends BaseState<HotPage, HotPresenter>
    with TickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  BaseListProvider<HotBeanTabinfoTablist> provider = BaseListProvider();

  TabController _tabController;
  PageController _pageController;

  int _tabSelectIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<BaseListProvider<HotBeanTabinfoTablist>>(
      builder: (context) => provider,
      child: Consumer<BaseListProvider<HotBeanTabinfoTablist>>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              //底部阴影
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: Text(
                "人气榜",
                style: MTextStyles.textBoldDark16,
              ),
              centerTitle: true,
              bottom: TabBar(
                controller: _initTabController(),
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                labelStyle: MTextStyles.textDark14,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 20.0),
                tabs: provider.list
                    .map((tab) => Tab(
                          text: tab.name,
                        ))
                    .toList(),
              ),
            ),
            body: provider.stateType==StateType.complete? Column(
              children: <Widget>[
                Container(
                  color: MColors.white_line,
                  height: 0.5,
                ),
                Expanded(
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: provider.list.length,
                        onPageChanged: _onPageChanged,
                        itemBuilder: (context, index) => HotListPage(
                              dataUrl: provider.list[index].apiUrl,
                              selectIndex: _tabSelectIndex,
                            )))
              ],
            ):StateLayout(
              type: provider.stateType,
            ),
          );
        },
      ),
    );
  }

  @override
  HotPresenter createPresenter() {
    return HotPresenter();
  }

  TabController _initTabController() {
    this._tabController = new TabController(
        length: provider.list.length,
        vsync: this,
        initialIndex: _tabSelectIndex);
    _tabController.addListener(_tabListener);
    return _tabController;
  }

  _tabListener() async {
    if (_tabController.index.toDouble() == _tabController.animation.value) {
      print(_tabController.index);
      _tabSelectIndex = _tabController.index;
      print("当前页面位置$_tabSelectIndex");
//      if(_pageController.hasClients) {
      _pageController.jumpToPage(_tabSelectIndex);
//      }
    }
  }

  _onPageChanged(int index) {
    _tabController.animateTo(index);
    _tabSelectIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    provider.setStateType(StateType.loading);
    _pageController = PageController(initialPage: 0);
    _initTabController();
    mPresenter.getHotTabData();
  }

  @override
  bool get wantKeepAlive => true;
}
