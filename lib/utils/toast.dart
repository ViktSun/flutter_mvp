import 'package:flutter/material.dart';
import 'package:flutter_mvp/res/styles.dart';
import 'package:oktoast/oktoast.dart';

class Toast {
  static show(String msg, {duration = 2000}) {
    showToast(msg, duration: Duration(milliseconds: duration));
  }

  static showExit(String msg, {duration = 2000}) {
    showToast(msg,
        duration: Duration(milliseconds: duration),
        backgroundColor: Colors.white,
        textStyle: MTextStyles.textDark14);
  }

  static dismiss() {
    dismissAllToast();
  }
}
