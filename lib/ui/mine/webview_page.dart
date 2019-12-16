import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvp/res/styles.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;

  final String url;

  const WebViewPage({@required this.title, @required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> controller = Completer();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, snapshot) {
        return WillPopScope(
          onWillPop: () => _onPageBack(snapshot),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: InkWell(
                  onTap: () {
                    Navigator.maybePop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              title: Text(
                widget.title,
                style: MTextStyles.textBoldDark18,
              ),
              backgroundColor: Colors.white,
            ),
            body: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (webViewController) {
                controller.complete(webViewController);
              },
            ),
          ),
        );
      },
    );
  }

  ///页面返回监听 如果Webview有内部链接页面则返回上个页面，否则退出Webview
  Future<bool> _onPageBack(AsyncSnapshot snapshot) async {
    if (snapshot.hasData) {
      var canGoBack = await snapshot.data.canGoBack();
      if (canGoBack) {
        //当网页可以返回到前一个页面时
        snapshot.data.goBack();
        return Future.value(false);
      }
      return Future.value(true);
    }
    return Future.value(true);
  }
}
