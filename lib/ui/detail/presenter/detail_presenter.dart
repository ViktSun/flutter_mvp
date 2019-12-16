import 'dart:collection';

import 'package:flutter_mvp/base/presenter/base_presenter.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/network/api/network_api.dart';
import 'package:flutter_mvp/network/network_util.dart';
import 'package:flutter_mvp/ui/detail/page/video_detail_page.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';

class DetailPresenter extends BasePresenter<VideoDetailPageState> {
  void requestRelatedVideo(String id) {
    Map<String, dynamic> params = new HashMap();
    params["id"] = id;
    requestDataFromNetwork<HomeItemIssuelist>(Method.get,
        url: Api.getRelatedData,
        queryParameters: params,
        isShow: false,
        isClose: false,
        isList: false,
        onSuccess: (data) {
          if (data != null) {
            if (data.itemList.isEmpty) {
              view.provider.list.clear();
              view.provider.setStateType(StateType.empty);
            } else {
              view.provider.list.addAll(data.itemList);
              view.provider.refresh();
            }
          } else {
            view.provider.clear();
            view.provider.setHasMore(false);
            view.provider.setStateType(StateType.network);
          }
        },
        onError: (code, msg) {
          print("ERRORMSG$msg");
        });
  }

}
