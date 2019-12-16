import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/ui/home/page/home_page.dart';
import 'package:flutter_mvp/ui/discovery/page/discovery_page.dart';
import 'package:flutter_mvp/ui/hot/page/hot_page.dart';
import 'package:flutter_mvp/ui/mine/mine_page.dart';
import 'package:flutter_mvp/utils/toast.dart';

///底部导航栏样式 pageView 和 CupertinoTabBar 实现导航
class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  //底部导航栏的Name
  final appBottomNavNames = ["精选", "发现", "热门", "我的"];

  //tab选中的字体样式
  final tabSelectStyle = TextStyle(color: Colors.black);

  //tab默认的字体样式
  final tabNormalStyle = TextStyle(color: Colors.grey);

  //选中的tab的Index
  int _tabSelectIndex = 0;

  //底部导航栏选中的图标
  var tabSelectImages;

  //底部导航栏未被选中的图标
  var tabNormalImages;

  //滑动的页面
  var _viewPager;

  //和tab对应的页面列表
  var _pages;

  DateTime _lastPressedAt;

  PageController _pageController;

  //用来加载底部导航栏的图标
  Image getTabImage(String path) {
    return Image.asset(
      path,
      width: 24.0,
      height: 24.0,
    );
  }

  //设置当前选中的字体颜色和样式
  TextStyle getTabTextStyle(int currentIndex) {
    return (currentIndex == _tabSelectIndex) ? tabSelectStyle : tabNormalStyle;
  }

  //初始化底部选择的图片
  void _initTabImages() {
    ///选中
    if (tabSelectImages == null) {
      tabSelectImages = [
        getTabImage("assets/images/ic_home_selected.png"),
        getTabImage("assets/images/ic_discovery_selected.png"),
        getTabImage("assets/images/ic_hot_selected.png"),
        getTabImage("assets/images/ic_mine_selected.png")
      ];
    }

    //默认图标
    if (tabNormalImages == null) {
      tabNormalImages = [
        getTabImage("assets/images/ic_home_normal.png"),
        getTabImage("assets/images/ic_discovery_normal.png"),
        getTabImage("assets/images/ic_hot_normal.png"),
        getTabImage("assets/images/ic_mine_normal.png")
      ];
    }
  }

  //获取底部图标
  Image _getTabIcon(int currentIndex) {
    return (currentIndex == _tabSelectIndex)
        ? tabSelectImages[currentIndex]
        : tabNormalImages[currentIndex];
  }

  //获取底部导航文字
  Text _getTabText(int currentIndex) {
    return Text(
      appBottomNavNames[currentIndex],
      style: getTabTextStyle(currentIndex),
    );
  }

  //初始化pageView
  void _initViewPager() {
    _viewPager = PageView(
      children: _pages,
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        setState(() {
          _tabSelectIndex = index;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);
    _pages = [HomePage(), DiscoveryPage(), HotPage(), MinePage()];
    _initViewPager();
    _initTabImages();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: exitApp,
        child: _viewPager,
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: _tabSelectIndex,
          onTap: (index) {
            _pageController.jumpToPage(index);
            setState(() {
              _tabSelectIndex = index;
            });
          },
          items: [
            //新特性 需要 sdk>2.2.2
            for (int i = 0; i < appBottomNavNames.length; i++)
              BottomNavigationBarItem(
                  icon: _getTabIcon(i), title: _getTabText(i))
          ]),
    );
  }

  Future<bool> exitApp(){
    if(_lastPressedAt==null||DateTime.now().difference(_lastPressedAt)
        >Duration(milliseconds: 2000)){
      _lastPressedAt = DateTime.now();
      Toast.showExit('再次点击退出应用程序');
      return Future.value(false);
    }
    Toast.dismiss();
    return Future.value(true);
  }
}
