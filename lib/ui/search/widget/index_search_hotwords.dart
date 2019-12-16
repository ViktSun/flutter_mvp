import 'package:flutter/material.dart';
import 'package:flutter_mvp/res/colors.dart';
import 'package:flutter_mvp/res/gaps.dart';

typedef OnKeywordsClickCallBack = Function(String keyWords);

class HomeSearchHotWords extends StatefulWidget {
  final OnKeywordsClickCallBack callBack;
  final List<String> tags;

  const HomeSearchHotWords({@required this.tags, this.callBack});

  @override
  _HomeSearchHotWordsState createState() => _HomeSearchHotWordsState();
}

class _HomeSearchHotWordsState extends State<HomeSearchHotWords> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Gaps.vGap30,
              Text(
                "输入标题或描述中的关键词找到更多视频",
                style: TextStyle(color: MColors.gray_9a, fontSize: 12.0),
              ),
              Gaps.vGap40,
              Text(
                "- 热门搜索词 -",
                style: TextStyle(color: MColors.gray_33, fontSize: 14.0),
              ),
              Gaps.vGap15,
              Wrap(
                spacing: 8.0,
                runSpacing: -5,
                runAlignment: WrapAlignment.center,
                children: widget.tags.map((tag) {
                  return InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      widget.callBack("$tag");
                    },
                    child: Chip(
                      backgroundColor: Color(0xffAAAAAA),
                      label: Text(
                        tag,
                        style: TextStyle(color: MColors.white, fontSize: 14.0),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
