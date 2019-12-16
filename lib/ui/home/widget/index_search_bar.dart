import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/ui/search/page/home_search_page.dart';

///用于滚动的时候搜索框样式的转换
class HomeSearchBar extends StatelessWidget {
  final bool showTopTitle;
  final String title;

  HomeSearchBar(this.showTopTitle, this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //跳转转场动画
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  return FadeTransition(
                      opacity: animation, child: HomeSearchPage());
                },
                transitionDuration: Duration(milliseconds: 500)));
      },
      child: !showTopTitle
          ? Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(bottom: 10.0, right: 10),
              child: Hero(
                tag: 'search',
                child: Image.asset(
                  "assets/images/ic_action_search_white.png",
                  height: 36.0,
                  width: 36.0,
                ),
              ),
              height: 80,
              width: double.infinity,
              color: Colors.transparent,
            )
          : Container(
              alignment: Alignment.bottomLeft,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: MColors.text_dark,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8.0, right: 10.0),
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      "assets/images/ic_action_search_black.png",
                      height: 36.0,
                      width: 36.0,
                    ),
                  ),
                ],
              ),
              height: 80,
              width: double.infinity,
              color: Colors.white70,
            ),
    );
  }
}
