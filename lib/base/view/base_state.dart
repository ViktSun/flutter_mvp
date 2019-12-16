import 'package:flutter/material.dart';
import 'package:flutter_mvp/routers/fluro_navigator.dart';
import 'package:flutter_mvp/utils/toast.dart';
import 'package:flutter_mvp/utils/utils.dart';
import 'package:flutter_mvp/widgets/progress_dialog.dart';

import '../presenter/base_presenter.dart';
import 'i_base_view.dart';

///将Presenter的生命周期和Widget的生命周期绑定
abstract class BaseState<T extends StatefulWidget, P extends BasePresenter>
    extends State<T> implements IBaseView {
  P mPresenter;

  BaseState() {
    mPresenter = createPresenter();
    mPresenter.view = this;
  }

  P createPresenter();

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void showProgress() {
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      try {
        showTransparentDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return WillPopScope(
                onWillPop: () async {
                  _isShowDialog = false;
                  return Future.value(true);
                },
                child: const ProgressDialog(
                  hintText: "正在加载...",
                ),
              );
            });
      } catch (e) {
        print(e);
      }
    }
  }

  bool _isShowDialog = false;

  @override
  void closeProgress() {
    if (mounted && !_isShowDialog) {
      _isShowDialog = false;
      NavigatorUtils.goBack(context);
    }
  }

  @override
  void showToast(String msg) {
    Toast.show(msg);
  }

  @override
  void initState() {
    super.initState();
    mPresenter.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mPresenter.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    mPresenter?.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    mPresenter.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateWidgets<T>(oldWidget);
  }

  void didUpdateWidgets<W>(W oldWidget) {
    mPresenter?.didUpdateWidget<W>(oldWidget);
  }
}
