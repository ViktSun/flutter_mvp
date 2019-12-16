import 'package:flutter_mvp/base/presenter/base_presenter.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/network/api/network_api.dart';
import 'package:flutter_mvp/network/network_util.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';

import '../page/follow_page.dart';

class FollowPresenter extends BasePresenter<FollowPageState> {
  Future requestFollowData() async{
   await requestFutureData<HomeItemIssuelist>(Method.get,
        url: Api.getFollowInfo,
        isShow: false,
        isClose: false,
        isList: false,
        onSuccess: (data) {
          if (data != null) {
            if (data.itemList.isEmpty) {
              view.provider.list.clear();
              view.provider.setStateType(StateType.empty);
            } else {
              view.provider.list.clear();
              view.provider.setStateType(StateType.complete);
              view.provider.list.addAll(data.itemList);
              view.provider.setNextPageUrl(data.nextPageUrl);
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

  Future requestLoadMore(String nextPage) async{
    await requestFutureData<HomeItemIssuelist>(Method.get,
        url: nextPage,
        isShow: false,
        isClose: false,
        isList: false,
        onSuccess: (data) {
          if (data != null) {
            if (data.itemList.isNotEmpty) {
              view.provider.setNextPageUrl(data.nextPageUrl);
              view.provider.list.addAll(data.itemList);
              view.provider.refresh();
            }
          } else {
            view.provider.setHasMore(false);
          }
        },
        onError: (code, msg) {

        });
  }


}
