import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/res/styles.dart';
import 'package:flutter_mvp/ui/discovery/category/page/category_page.dart';
import 'package:flutter_mvp/ui/discovery/followitem/page/follow_page.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  PageController _pageController;

  List<Widget> _pages;

  PageView _pageView;

  int _tabSelectIndex = 0;

  List tabs = ["关注", "分类"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "发现",
          style: MTextStyles.textBoldDark16,
        ),
        bottom: TabBar(
            indicatorColor: Colors.black,
            controller: _tabController,
            labelColor: Colors.black,
            labelStyle: MTextStyles.textDark16,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 40.0),
            tabs: tabs
                .map((text) => Tab(
                      text: text,
                    ))
                .toList()),
      ),
      body: Column(
        children: <Widget>[
          Container(color: MColors.white_line,height: 0.5,),
          Expanded(child: _pageView)
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _pageController = PageController(initialPage: 0, keepPage: true);
    _pages = [FollowPage(), CategoryPage()];
    _initViewPager();

    _tabController.addListener((){
      if(_tabController.index.toDouble()==_tabController.animation.value){
        _tabSelectIndex = _tabController.index;
        _pageController.jumpToPage(_tabSelectIndex);
      }
    });

//    _pageController.addListener((){
//      setState(() {
//       print("${_pageController.page}");
//      });
//    });
  }

  void _initViewPager() {
    _pageView = PageView(
      children: _pages,
      physics: ClampingScrollPhysics(),
      controller: _pageController,
      onPageChanged: (index) {
        _tabController.animateTo(index);
        _tabSelectIndex = index;
      },
    );
  }
}
