import 'package:flutter_mvp/base/presenter/base_presenter.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/network/api/network_api.dart';
import 'package:flutter_mvp/network/network_util.dart';
import 'package:flutter_mvp/ui/search/page/home_search_page.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';

class HomeSearchPresenter extends BasePresenter<HomeSearchPageState> {
  void getHotWords() {
    requestDataFromNetwork<String>(Method.get,
        url: Api.getHotWords,
        isShow: false,
        isClose: false,
        isList: true, onSuccessList: (data) {
      if (data.isEmpty) {
        view.tagProvider.list.clear();
        view.tagProvider.setStateType(StateType.empty);
      } else {
        view.tagProvider.list.addAll(data);
        view.tagProvider.refresh();
      }
    }, onError: (code, msg) {
      print("ERRORMSG${msg}");
    });
  }

  Future search(String query) async {
    Map<String, dynamic> queryParams = Map();
    queryParams["query"] = query;
    await requestFutureData<HomeItemIssuelist>(Method.get,
        url: Api.getSearchData,
        isShow: false,
        isClose: false,
        queryParams: queryParams,
        isList: false, onSuccess: (data) {
      if (data != null) {
          view.tagProvider.clear();
        if (data.itemList.isEmpty) {
          view.dataProvider.list.clear();
          view.dataProvider.setTotalCount(data.total);
          view.dataProvider.setStateType(StateType.empty);
        } else {
          view.dataProvider.list.clear();
          view.dataProvider.setTotalCount(data.total);
          view.dataProvider.list.addAll(data.itemList);
          view.dataProvider.setNextPageUrl(data.nextPageUrl);
          view.dataProvider.setStateType(StateType.complete);
          view.dataProvider.refresh();
        }
      } else {
        view.dataProvider.clear();
        view.dataProvider.setTotalCount(data.total);
        view.dataProvider.setHasMore(false);
        view.dataProvider.setStateType(StateType.empty);
      }
    }, onError: (code, msg) {
      view.dataProvider.setStateType(StateType.network);
    });
  }

  Future searchMore(String nextUrl) async {
    await requestFutureData<HomeItemIssuelist>(Method.get,
        url: nextUrl,
        isShow: false,
        isClose: false,
        isList: false, onSuccess: (data) {
      if (data != null) {
        view.dataProvider.setHasMore(data.nextPageUrl.isNotEmpty);
        if (data.itemList.isEmpty) {
          view.dataProvider.setStateType(StateType.empty);
        } else {
          view.dataProvider.setNextPageUrl(data.nextPageUrl);
          view.dataProvider.addAll(data.itemList);
        }
      } else {
        view.dataProvider.setHasMore(false);
      }
    }, onError: (code, msg) {
      print("网络异常");
    });
  }
}
