import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutter_mvp/routers/router_init.dart';
import 'package:flutter_mvp/ui/bottomnav/bottom_nav.dart';

class HomeRouter implements IRouterProvider {
  static String homePage = "/home/index";

  @override
  void initRouter(Router router) {
    router.define(homePage,
        handler: Handler(handlerFunc: (_, params) => BottomNav()));
  }
}
