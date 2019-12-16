import 'package:flutter_mvp/base/presenter/base_presenter.dart';
import 'package:flutter_mvp/bean/hot_bean_entity.dart';
import 'package:flutter_mvp/network/api/network_api.dart';
import 'package:flutter_mvp/network/network_util.dart';
import 'package:flutter_mvp/ui/hot/page/hot_page.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';

class HotPresenter extends BasePresenter<HotPageState> {
  void getHotTabData() {
//    WidgetsBinding.instance
//        .addPostFrameCallback((_){
      requestDataFromNetwork<HotBeanEntity>(Method.get,
          url: Api.getRankList,
          isShow: false,
          isClose: false,
          isList: false,
          onSuccess: (data) {
            if(data!=null){
              if(data.tabInfo.tabList.isNotEmpty){
                view.provider.setStateType(StateType.complete);
                view.provider.list.clear();
                view.provider.list.addAll(data.tabInfo.tabList);
                view.provider.refresh();
              }else{
                view.provider.setStateType(StateType.empty);
              }
            }else{
              view.provider.setStateType(StateType.empty);
            }
          },onError: (code,msg){
          view.provider.setStateType(StateType.network);
          });

//    });

  }
}
