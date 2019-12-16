import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/res/gaps.dart';
import 'package:flutter_mvp/res/styles.dart';
import 'package:flutter_mvp/utils/image_utils.dart';

class StateLayout extends StatefulWidget {
  final StateType type;
  final String hintText;

  const StateLayout({Key key, @required this.type, this.hintText})
      : super(key: key);

  @override
  _StateLayoutState createState() => _StateLayoutState();
}

class _StateLayoutState extends State<StateLayout> {
  @override
  Widget build(BuildContext context) {
    String _img;
    String _hintText;
    switch (widget.type) {
      case StateType.network:
        _img = "netError";
        _hintText = "无网络连接";
        break;
      case StateType.empty:
        _img = "empty";
        _hintText = "什么也没有";
        break;
      case StateType.loading:
        _img = "";
        _hintText = "";
        break;
      case StateType.complete:
        _img = "";
        _hintText = "";
    }
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.type == StateType.loading
              ? const CupertinoActivityIndicator(
                  radius: 16.0,
                )
              : (widget.type == StateType.complete
                  ? Gaps.empty
                  : Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  ImageUtils.getImagePath("state/$_img")))),
                    )),
          Gaps.vGap16,
          Text(
            widget.hintText ?? _hintText,
            style: MTextStyles.textGray14,
          ),
          Gaps.vGap50
        ],
      ),
    );
  }
}

enum StateType {
  ///网络错误
  network,

  ///页面为空
  empty,

  ///加载中
  loading,

  ///加载完成
  complete
}
