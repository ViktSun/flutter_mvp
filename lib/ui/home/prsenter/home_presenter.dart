import 'package:flutter_mvp/base/presenter/base_presenter.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/network/api/network_api.dart';
import 'package:flutter_mvp/network/network_util.dart';
import 'package:flutter_mvp/ui/home/page/home_page.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';

///首页数据
class HomePresenter extends BasePresenter<HomePageState> {

  Future refreshHomeData() async {
    await requestFutureData<HomeBeanEntity>(Method.get,
        url: Api.getFirstHomeData,
        isShow: false,
        isClose: false,
        isList: false,
        onSuccess: (data) {
          if (data != null) {
            getHomeMoreData(data.nextPageUrl, isFirst: true);
            view.provider.setHasMore(data.nextPageUrl.isNotEmpty);
            if (data.issueList[0].itemList.isEmpty) {
              view.provider.list.clear();
              view.provider.setStateType(StateType.empty);
            } else {
//              var banner = HomeItemIssuelistItemlist();
//              banner.type = "banner";
//              view.provider.list.clear();
//              view.provider.insert(0, banner);
              view.provider.setBannerData(data.issueList[0].itemList);
            }
          } else {
            view.provider.setHasMore(false);
            view.provider.setStateType(StateType.empty);
          }
        },
        onError: (code, msg) {
          view.provider.setStateType(StateType.network);
        });
  }


//  Future getHomeMoreData(String nextPageUrl) async {
//    await requestFutureData<HomeBeanEntity>(Method.get,
//        url: nextPageUrl,
//        isShow: true,
//        isClose: true,
//        isList: false,
//        onSuccess: (data) {
//          if (data != null) {
//            view.provider.setHasMore(data.nextPageUrl.isNotEmpty);
//            if (data.issueList[0].itemList.isEmpty) {
//              view.provider.setStateType(StateType.empty);
//            } else {
//              view.provider.setNextPageUrl(data.nextPageUrl);
//              view.provider.addAll(data.issueList[0].itemList);
//            }
//          } else {
//            view.provider.setHasMore(false);
//            view.provider.setStateType(StateType.network);
//          }
//        });
//  }

  //获取首页加载更多数据
  Future getHomeMoreData(String nextPageUrl, {bool isFirst: false}) async {
    await requestFutureData<HomeBeanEntity>(Method.get,
        url: nextPageUrl,
        isShow: false,
        isClose: false,
        isList: false,
        onSuccess: (data) {
          if (data != null) {
            view.provider.setHasMore(data.nextPageUrl.isNotEmpty);
            if (data.issueList[0].itemList.isEmpty) {
              view.provider.setStateType(StateType.empty);
            } else {
              //如果是第一次加载 把banner图和第一页数据一块返回
              if (isFirst) {
                var banner = HomeItemIssuelistItemlist();
                banner.type = "banner";
                view.provider.list.clear();
                view.provider.insert(0, banner);
              }
              view.provider.setNextPageUrl(data.nextPageUrl);
              view.provider.addAll(data.issueList[0].itemList);
            }
          } else {
            view.provider.setHasMore(false);
//            view.provider.setStateType(StateType.network);
          }
        },
        onError: (code, msg) {
          if (isFirst) {
            view.provider.setStateType(StateType.network);
          }
        });
  }
}
