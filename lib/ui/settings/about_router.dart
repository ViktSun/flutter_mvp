import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutter_mvp/routers/router_init.dart';
import 'package:flutter_mvp/ui/settings/about_app_page.dart';

class AboutRouter implements IRouterProvider {
  static String aboutPage = '/settings/about';

  @override
  void initRouter(Router router) {
    router.define(aboutPage,
        handler: Handler(handlerFunc: (_, params) => AboutAppPage()));
  }
}
