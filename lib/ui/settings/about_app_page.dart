import 'package:flutter/material.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/res/dimens.dart';
import 'package:flutter_mvp/res/gaps.dart';
import 'package:flutter_mvp/res/styles.dart';
import 'package:flutter_mvp/routers/fluro_navigator.dart';
import 'package:flutter_mvp/utils/image_utils.dart';
import 'package:package_info/package_info.dart';

class AboutAppPage extends StatefulWidget {
  @override
  _AboutAppPageState createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  String appVersion = "";
  String about = "内容部分数据归原公司《开眼Eyepetizer》版权所有";
  String aboutContent = "本APP只供学习交流和研究之用，\n请勿用作商业用途！";
  String copyRight = "copyright ©2019 VickSun.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            NavigatorUtils.goBack(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: MColors.text_dark,
          ),
        ),
        title: Text(
          '关于',
          style: MTextStyles.textBoldDark20,
        ),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: 48.0,
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () => NavigatorUtils.goWebViewPage(context, "GitHub",
                        "https://github.com/ViktSun/flutter_mvp"),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'GitHub',
                          style: MTextStyles.textGray14,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: MColors.text_gray,
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: MColors.dart_light_color,
                ),
                Container(
                  height: 48.0,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '意见反馈',
                        style: MTextStyles.textGray14,
                      ),
                      Icon(Icons.chevron_right, color: MColors.text_gray)
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 16.0,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    ImageUtils.getImagePath("web_hi_res_512"),
                    height: 100.0,
                    width: 100.0,
                  ),
                  Gaps.vGap10,
                  Text(
                    "Flutter Mvp",
                    style: TextStyle(
                        fontSize: Dimens.font_sp18,
                        color: MColors.text_dark,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lobster'),
                  ),
                  Gaps.vGap12,
                  Text(
                    appVersion,
                    style: MTextStyles.textGray12,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20.0,
              child: Column(
                children: <Widget>[
                  Text(
                    about,
                    style: MTextStyles.textGray12,
                    textAlign: TextAlign.center,
                  ),
                  Gaps.vGap8,
                  Text(
                    aboutContent,
                    style: MTextStyles.textGray12,
                    textAlign: TextAlign.center,
                  ),
                  Gaps.vGap16,
                  Text(
                    copyRight,
                    textAlign: TextAlign.center,
                    style: MTextStyles.textGray12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getAppVersion();
    super.initState();
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = "v ${packageInfo.version}";
    setState(() {});
  }
}
