import 'package:flutter_mvp/base/presenter/base_presenter.dart';
import 'package:flutter_mvp/bean/catetory_bean_entity.dart';
import 'package:flutter_mvp/network/api/network_api.dart';
import 'package:flutter_mvp/network/network_util.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';

import '../page/category_page.dart';

class CategoryPresenter extends BasePresenter<CategoryPageState> {
  void requestCategoryData() {
    requestDataFromNetwork<CategoryBeanEntity>(Method.get,
        url: Api.getCategory,
        isShow: false,
        isClose: false,
        isList: true, onSuccessList: (data) {
      if (data != null) {
        if (data.isEmpty) {
          view.provider.list.clear();
          view.provider.setStateType(StateType.empty);
        } else {
          view.provider.setStateType(StateType.complete);
          view.provider.list.clear();
          view.provider.list.addAll(data);
          view.provider.refresh();
        }
      } else {
        view.provider.clear();
        view.provider.setHasMore(false);
        view.provider.setStateType(StateType.empty);
      }
    }, onError: (code, msg) {
          view.provider.setStateType(StateType.network);
        });

  }
}
