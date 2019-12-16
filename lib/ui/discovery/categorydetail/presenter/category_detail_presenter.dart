
import 'package:flutter_mvp/base/presenter/base_presenter.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/network/api/network_api.dart';
import 'package:flutter_mvp/network/network_util.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';

import '../page/category_detail_page.dart';

class CategoryDetailPresenter extends BasePresenter<CategoryDetailPageState> {
  Future requestCategoryDetailData(String id) async {
    Map<String, dynamic> queryParams = Map();
    queryParams["id"] = id;
    queryParams["udid"]= 'd2807c895f0348a180148c9dfa6f2feeac0781b5';
    await requestFutureData<HomeItemIssuelist>(Method.get,
        url: Api.getCategoryDetailList,
        isShow: false,
        isClose: false,
        queryParams: queryParams,
        isList: false, onSuccess: (data) {
      if (data != null) {
        if (data.itemList.isEmpty) {
          view.provider.list.clear();
          view.provider.setStateType(StateType.empty);
        } else {
          view.provider.setStateType(StateType.complete);
          view.provider.list.clear();
          view.provider.setNextPageUrl(data.nextPageUrl);
          view.provider.list.addAll(data.itemList);
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

  Future getMoreData(String nextPageUrl) async {
    Map<String, dynamic> queryParams = Map();
    queryParams["udid"]= 'd2807c895f0348a180148c9dfa6f2feeac0781b5';
    await requestFutureData<HomeItemIssuelist>(Method.get,
        url: nextPageUrl,
        queryParams: queryParams,
        isShow: false,
        isClose: false,
        isList: false, onSuccess: (data) {
      if (data != null) {
        view.provider.setHasMore(data.nextPageUrl.isNotEmpty);
        if (data.itemList.isEmpty) {
          view.provider.setStateType(StateType.empty);
        } else {
          view.provider.setNextPageUrl(data.nextPageUrl);
          view.provider.addAll(data.itemList);
        }
      } else {
        view.provider.setHasMore(false);
      }
    }, onError: (code, msg) {});
  }
}
