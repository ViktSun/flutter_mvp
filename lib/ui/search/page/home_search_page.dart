import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/provider/base_list_provider.dart';
import 'package:flutter_mvp/base/view/base_state.dart';
import 'package:flutter_mvp/bean/home_bean_entity.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/res/gaps.dart';
import 'package:flutter_mvp/ui/hot/widget/hot_item.dart';
import 'package:flutter_mvp/ui/search/widget/index_search_hotwords.dart';
import 'package:flutter_mvp/ui/search/presenter/search_presenter.dart';
import 'package:flutter_mvp/widgets/my_refresh_list.dart';
import 'package:flutter_mvp/widgets/search_widget.dart';
import 'package:flutter_mvp/widgets/search_ripple.dart';
import 'package:provider/provider.dart';

class HomeSearchPage extends StatefulWidget {
  @override
  HomeSearchPageState createState() => HomeSearchPageState();
}

class HomeSearchPageState extends BaseState<HomeSearchPage, HomeSearchPresenter>
    with TickerProviderStateMixin {
  String keyWords = "";
  TextEditingController controller = TextEditingController();
  BaseListProvider<String> tagProvider = BaseListProvider<String>();
  FocusNode blankFocusNode = FocusNode();
  BaseListProvider<HomeItemIssuelistItemlist> dataProvider = BaseListProvider();
  AnimationController animationController;
  Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchWidget(
        controller: controller,
        onCancelSearch: onSearchCancel,
        prefixIconColor: MColors.gray_99,
        editTextBackgroudColor: Color(0xffdddddd),
        hintText: '帮你找到感兴趣的视频',
        onSearchCallback: onSearch,
      ),
      body: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SearchRipple(
            revealPercent: animation.value,
            child: Container(
              color: MColors.gray_ee,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  Hero(
                    tag: "search",
                    flightShuttleBuilder: (flightContext, animation, direction,
                        fromContext, toContext) {
                      animation.addStatusListener((status) {
                        //监听到当Hero动画结束时 执行ripple动画
                        if (status == AnimationStatus.completed) {
                          animationController.forward();
                        }
                      });
                      return Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: MColors.gray_ee, shape: BoxShape.circle));
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: MColors.gray_ee, shape: BoxShape.circle),
                    ),
                  ),

                  ChangeNotifierProvider<BaseListProvider<String>>(
                    builder: (_) => tagProvider,
                    child: Consumer<BaseListProvider<String>>(
                      builder: (context, provider, _) {
                        return Opacity(
                          opacity: keyWords.isEmpty ? 1.0 : 0.0,
                          child: Container(
                            child: HomeSearchHotWords(
                              tags: provider.list,
                              callBack: onSearch,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ChangeNotifierProvider<
                      BaseListProvider<HomeItemIssuelistItemlist>>(
                    builder: (_) => dataProvider,
                    child:
                        Consumer<BaseListProvider<HomeItemIssuelistItemlist>>(
                      builder: (context, dataProvider, _) {
                        return Opacity(
                          opacity: keyWords.isEmpty ? 0.0 : 1.0,
                          child: Column(
                            children: <Widget>[
                              Gaps.vGap30,
                              Text(
                                  "-「$keyWords」搜索结果共${dataProvider.totalCount}个-"),
                              Gaps.vGap30,
                              Expanded(
                                child: RefreshList(
                                  padding: EdgeInsets.only(top: 0),
                                  itemCount: dataProvider.list.length,
                                  stateType: dataProvider.stateType,
                                  indicatorFrontColor: MColors.white,
                                  onRefresh: _refresh,
                                  indicatorBackgroundColor:
                                      MColors.transparent_60,
                                  loadMore: _loadMore,
                                  hasMore: dataProvider.hasMore,
                                  itemBuilder: (context, index) {
                                    return HotItem(dataProvider.list[index]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    CurvedAnimation _curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOutSine);
    animation = Tween(begin: 0.0, end: 1.0).animate(_curvedAnimation);
    mPresenter.getHotWords();
    super.initState();
  }

  @override
  HomeSearchPresenter createPresenter() {
    return HomeSearchPresenter();
  }

  Future _loadMore() async {
    await mPresenter.searchMore(dataProvider.nextPageUrl);
  }

  Future _refresh() async {
    await mPresenter.search(keyWords);
  }

  void onSearchCancel() {
    Navigator.pop(context);
  }

  void onSearch(String keyWords) {
    this.keyWords = keyWords;
    controller.text = keyWords;
    FocusScope.of(context).requestFocus(blankFocusNode);
    _refresh();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
