import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/res/gaps.dart';
import 'package:flutter_mvp/widgets/state_layout.dart';

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class RefreshList extends StatefulWidget {
  const RefreshList(
      {Key key,
      @required this.itemCount,
      @required this.itemBuilder,
      @required this.onRefresh,
      this.loadMore,
      this.hasMore: false,
      this.stateType: StateType.empty,
      this.pageSize: 10,
      this.padding,
      this.isShowMoreView: true,
      this.indicatorFrontColor,
      this.indicatorBackgroundColor,
      this.scrollController,
      this.itemExtent})
      : super(key: key);

  final RefreshCallback onRefresh;
  final LoadMoreCallback loadMore;
  final int itemCount; //列表Item数量
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final StateType stateType;

  final int pageSize;
  final EdgeInsetsGeometry padding;
  final double itemExtent;

  final Color indicatorBackgroundColor;
  final Color indicatorFrontColor;
  final bool isShowMoreView;
  final ScrollController scrollController;

  @override
  _RefreshListState createState() => _RefreshListState();
}

class _RefreshListState extends State<RefreshList> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent &&
            note.metrics.axis == Axis.vertical) {
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        backgroundColor: widget.indicatorBackgroundColor,
        color: widget.indicatorFrontColor,
        onRefresh: widget.onRefresh,
        child: widget.itemCount == 0
            ? StateLayout(
                type: widget.stateType,
              )
            : ListView.builder(
                itemCount: widget.loadMore == null
                    ? widget.itemCount
                    : widget.itemCount + 1,
                padding: widget.padding,
                itemExtent: widget.itemExtent,
                controller: widget.scrollController,
                itemBuilder: (context, index) {
                  if (widget.loadMore == null) {
                    return widget.itemBuilder(context, index);
                  } else {
                    return index < widget.itemCount
//                  && context.size.height>
//                  MediaQuery.of(context).size.height
                        ? widget.itemBuilder(context, index)
                        : widget.isShowMoreView
                            ? LoadMoreWidget(widget.itemCount, widget.hasMore,
                                widget.pageSize)
                            : Container();
                  }
                },
              ),
      ),
    );
  }

  Future _loadMore() async {
    if (widget.loadMore == null) {
      return;
    }
    if (_isLoading) {
      return;
    }

    if (!widget.hasMore) {
      return;
    }

    _isLoading = true;
    await widget.loadMore();
    _isLoading = false;
  }
}

class LoadMoreWidget extends StatelessWidget {
  const LoadMoreWidget(this.itemCount, this.hasMore, this.pageSize);

  final int itemCount;
  final bool hasMore;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          hasMore ? const CupertinoActivityIndicator() : Gaps.empty,
          hasMore ? Gaps.hGap5 : Gaps.empty,
          Text(
            hasMore ? '正在加载中...' : (itemCount < pageSize ? '' : '没有更多了~'),
            style: TextStyle(color: Color(0x8A000000)),
          )
        ],
      ),
    );
    ;
  }
}
