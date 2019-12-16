import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/res/dimens.dart';
import 'package:flutter_mvp/res/gaps.dart';
import 'package:flutter_mvp/res/styles.dart';
import 'package:flutter_mvp/routers/fluro_navigator.dart';
import 'package:flutter_mvp/ui/home/home_router.dart';
import 'package:flutter_mvp/utils/image_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription _subscription;
  String appVersion = "";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(top: 120.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        ImageUtils.getImagePath("web_hi_res_512"),
                        height: 100.0,
                        width: 100.0,
                      ),
                      Gaps.vGap10,
                      Text("Flutter Mvp", style: TextStyle(
                          fontSize: Dimens.font_sp18,
                          color: MColors.text_dark,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lobster'
                      ),),
                    ],
                  )),
            ),
            const Text(
              "每日精选，让你大开眼界",
              style: TextStyle(
                  fontSize: Dimens.font_sp14,
                  color: MColors.text_dark,
                  fontFamily: "FZLanTingHeiS"
              ),
            ),
            Gaps.vGap10,
            Text(
              appVersion,
              style: MTextStyles.textGray12,
            )
          ],
        ),
      ),
    );
  }


  void _initSplash() {
    _subscription = Observable.just(1).delay(Duration(seconds: 2)).listen((_) {
      NavigatorUtils.push(context, HomeRouter.homePage, replace: true);
    });
  }

  @override
  void initState() {
    super.initState();
    _initSplash();
    getAppVersion();
  }

  @override
  void dispose() {
    super.dispose();
    if (_subscription != null) {
      _subscription.cancel();
    }
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = "v ${packageInfo.version}";
    setState(() {
    });
  }
}
