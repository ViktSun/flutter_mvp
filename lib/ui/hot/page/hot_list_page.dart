import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/provider/base_list_provider.dart';
import 'package:flutter_mvp/base/view/base_state.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/ui/hot/widget/hot_item.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';
import 'package:provider/provider.dart';

import '../presenter/hot_list_presenter.dart';

class HotListPage extends StatefulWidget {
  const HotListPage(
      {Key key, @required this.dataUrl, @required this.selectIndex})
      : super(key: key);
  final String dataUrl;
  final int selectIndex;

  @override
  HotListPageState createState() => HotListPageState();
}

class HotListPageState extends BaseState<HotListPage, HotListPresenter> with AutomaticKeepAliveClientMixin {
  BaseListProvider<HomeItemIssuelistItemlist> provider = BaseListProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<HomeItemIssuelistItemlist>>(
      builder: (_) => provider,
      child: Consumer<BaseListProvider<HomeItemIssuelistItemlist>>(
          builder: (context, provider, child) {
        return
          provider.stateType!=StateType.complete
            ?  StateLayout(type: provider.stateType)
            : ListView.builder(
                itemCount: provider.list.length,
                itemBuilder: (context, index) {
                  return HotItem(provider.list[index]);
                });
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    mPresenter.requestRankData(widget.dataUrl);
  }

  @override
  HotListPresenter createPresenter() {
    return HotListPresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
