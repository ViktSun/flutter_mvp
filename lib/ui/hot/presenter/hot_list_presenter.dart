
import 'package:flutter_mvp/base/presenter/base_presenter.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/network/network_util.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';
import '../page/hot_list_page.dart';

class HotListPresenter extends BasePresenter<HotListPageState> {
   requestRankData(String url) {
    requestDataFromNetwork<HomeItemIssuelist>(Method.get,
        url: url,
        isShow: false,
        isClose: false,
        isList: false,
        onSuccess: (data) {
          if (data != null) {
            if (data.itemList.isEmpty) {
              view.provider.list.clear();
              view.provider.setStateType(StateType.empty);
            } else {
              view.provider.setStateType(StateType.complete);
              view.provider.list.clear();
              view.provider.list.addAll(data.itemList);
              view.provider.refresh();
            }
          } else {
            view.provider.clear();
            view.provider.setHasMore(false);
            view.provider.setStateType(StateType.empty);
          }
        },
        onError: (code, msg) {
          view.provider.setStateType(StateType.network);
        });
  }



}
