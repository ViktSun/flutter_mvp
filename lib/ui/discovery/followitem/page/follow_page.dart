

import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/provider/base_list_provider.dart';
import 'package:flutter_mvp/base/view/base_state.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/ui/discovery/followitem/presenter/follow_presenter.dart';
import 'package:flutter_mvp/widgets/my_refresh_list.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';
import 'package:provider/provider.dart';

import '../widget/follow_v_item.dart';

class FollowPage extends StatefulWidget {
  @override
  FollowPageState createState() => FollowPageState();
}


class FollowPageState extends BaseState<FollowPage,FollowPresenter> with AutomaticKeepAliveClientMixin {

  BaseListProvider<HomeItemIssuelistItemlist> provider = BaseListProvider();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: ChangeNotifierProvider<BaseListProvider<HomeItemIssuelistItemlist>>(
        builder: (_)=>provider,
        child: Consumer<BaseListProvider<HomeItemIssuelistItemlist>>(
          builder:(context,provider,child){
           return provider.stateType== StateType.complete? RefreshList(
             itemCount: provider.list.length,
             onRefresh: _onRefresh,
             indicatorFrontColor: Colors.black,
             loadMore: _loadMore,
             stateType: provider.stateType,
             hasMore: provider.nextPageUrl!=null,
             itemBuilder: (context,index){
               return FollowVItem(provider.list[index]);
             },

           ):StateLayout(
             type: provider.stateType,
           );
          } ,
    )
      )
    );
  }

  Future _onRefresh() async{
   await mPresenter.requestFollowData();
  }

  Future _loadMore() async{
    await mPresenter.requestLoadMore(provider.nextPageUrl);
  }

  @override
  void initState() {
    provider.setStateTypeNotify(StateType.loading);
    super.initState();
    _onRefresh();
  }

  @override
  FollowPresenter createPresenter() {
    return FollowPresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
