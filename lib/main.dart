import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvp/routers/application.dart';
import 'package:flutter_mvp/routers/routers.dart';
import 'package:oktoast/oktoast.dart';

import 'ui/splash/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //状态栏透明
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }


  //强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });

//  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp(
            title: 'Flutter Mvp',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashPage()),
        backgroundColor: Colors.black54,
        textPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom,
        dismissOtherOnShow: true);
  }
}
