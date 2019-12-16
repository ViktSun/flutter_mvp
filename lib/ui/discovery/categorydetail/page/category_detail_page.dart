import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/provider/base_list_provider.dart';
import 'package:flutter_mvp/base/view/base_state.dart';
import 'package:flutter_mvp/bean/catetory_bean_entity.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/ui/hot/widget/hot_item.dart';
import 'package:flutter_mvp/widgets/my_flexible_space_bar.dart';
import 'package:flutter_mvp/widgets/my_refresh_list.dart';
import 'package:flutter_mvp/utils/image_loader.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';
import 'package:provider/provider.dart';

import '../presenter/category_detail_presenter.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage(this.mData);

  final CategoryBeanEntity mData;

  @override
  CategoryDetailPageState createState() => CategoryDetailPageState();
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class CategoryDetailPageState
    extends BaseState<CategoryDetailPage, CategoryDetailPresenter> {
  BaseListProvider<HomeItemIssuelistItemlist> provider = BaseListProvider();
  final double _appBarHeight = 200.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    provider.setStateType(StateType.loading);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (ScrollNotification note) {
          if (note.metrics.pixels == note.metrics.maxScrollExtent) {
            _loadMore();
          }
          return true;
        },
        child: RefreshIndicator(
          color: Colors.black,
          onRefresh: _refresh,
          displacement: 60,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    )),
                backgroundColor: Colors.white,
                expandedHeight: _appBarHeight,
                elevation: 0.0,
                pinned: true,
                floating: false,
                snap: false,
                flexibleSpace: MyFlexibleSpaceBar(
                  title: Text(widget.mData.name),
                  centerTitle: true,
                  titlePadding: EdgeInsets.only(left: 16.0, bottom: 16),
                  background: Hero(
                      tag: widget.mData,
                      child: ImageLoader.loadDefault(widget.mData.headerImage)),
                ),
              ),
              ChangeNotifierProvider<
                  BaseListProvider<HomeItemIssuelistItemlist>>(
                builder: (_) => provider,
                child: Consumer<BaseListProvider<HomeItemIssuelistItemlist>>(
                    builder: (context, provider, child) {
                  return provider.list.isEmpty
                      ? SliverFillRemaining(
                          child: StateLayout(
                            type: provider.stateType,
                          ),
                        )
                      : SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                          return index < provider.list.length
                              ? HotItem(provider.list[index])
                              : LoadMoreWidget(provider.list.length,
                                  provider.nextPageUrl.isNotEmpty, 10);
                        }, childCount: provider.list.length + 1));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _refresh() async {
    await mPresenter.requestCategoryDetailData(widget.mData.id.toString());
  }

  Future _loadMore() async {
    if (_isLoading) return;
    _isLoading = true;
    await mPresenter.getMoreData(provider.nextPageUrl);
    _isLoading = false;
  }

  @override
  CategoryDetailPresenter createPresenter() {
    return CategoryDetailPresenter();
  }
}
