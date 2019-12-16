import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/provider/base_list_provider.dart';
import 'package:flutter_mvp/base/view/base_state.dart';
import 'package:flutter_mvp/bean/catetory_bean_entity.dart';
import 'package:flutter_mvp/ui/discovery/categorydetail/widget/category_item.dart';
import 'package:flutter_mvp/ui/discovery/category/presenter/category_presenter.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends BaseState<CategoryPage, CategoryPresenter>
    with AutomaticKeepAliveClientMixin {
  BaseListProvider<CategoryBeanEntity> provider = BaseListProvider();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<BaseListProvider<CategoryBeanEntity>>(
      builder: (_) => provider,
      child: Consumer<BaseListProvider<CategoryBeanEntity>>(
        builder: (context, provider, child) {
          return provider.stateType == StateType.complete
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.0),
                  itemCount: provider.list.length,
                  itemBuilder: (context, index) {
                    return CategoryItem(provider.list[index]);
                  },
                )
              : StateLayout(
                  type: provider.stateType,
                );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mPresenter.requestCategoryData();
  }

  @override
  CategoryPresenter createPresenter() {
    return CategoryPresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
