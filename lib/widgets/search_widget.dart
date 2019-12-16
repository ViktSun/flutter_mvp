import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvp/res/colors.dart';

typedef OnChangedCallback = Future<void> Function();

typedef OnCancelSearch = Function();

typedef OnSearchCallback = Function(String content);

class SearchWidget extends StatefulWidget implements PreferredSizeWidget {
  final double height; //搜索框高度
  final double elevation; //阴影
  final Widget leading; //返回图标
  final String hintText; //提示语
  final FocusNode focusNode;
  final TextEditingController controller;
  final IconData prefixIcon;
  final Color prefixIconColor;
  final Color editTextBackgroudColor;
  final Color backgroudColor;
  final List<TextInputFormatter> inputFormatters;
  final VoidCallback onEditingComplete;
  final OnChangedCallback onChangedCallback;
  final OnCancelSearch onCancelSearch;
  final OnSearchCallback onSearchCallback;

  const SearchWidget(
      {Key key,
      this.height: 46,
      this.elevation: 0.0,
      this.leading,
      this.hintText: '输入搜索关键字',
      this.focusNode,
      this.controller,
      this.inputFormatters,
      this.onEditingComplete,
      this.onChangedCallback,
      this.prefixIconColor: Colors.black54,
      this.editTextBackgroudColor: Colors.grey,
      this.backgroudColor: MColors.gray_ee,
      this.onSearchCallback,
      this.onCancelSearch,
      this.prefixIcon: Icons.search})
      : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _SearchWidgetState extends State<SearchWidget> {
  bool _hasSelectIcon = false;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(widget.height),
      child: Container(
        color: widget.backgroudColor,
        child: Stack(
          children: <Widget>[
            InkWell(
              //取消搜索时候触发
              onTap: () {
                widget.onCancelSearch();
              },
              child: Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 24),
                child: Text(
                  '取消',
                  style: TextStyle(fontSize: 14, color: MColors.gray_66),
                ),
              ),
            ),
            Offstage(
              offstage: false,
              child: Container(
                child: Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(top: 30, left: 30, right: 60, bottom: 10),
                  child: TextField(
                    focusNode: widget.focusNode,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    controller: widget.controller,
                    maxLines: 1,
                    inputFormatters: widget.inputFormatters,
                    style: TextStyle(color: MColors.gray_33, fontSize: 14.0),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle:
                          TextStyle(color: MColors.gray_9a, fontSize: 14.0),
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 0.0,
                        ),
                        child: Icon(
                          widget.prefixIcon,
                          color: widget.prefixIconColor,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 2.0, end: _hasSelectIcon ? 0.0 : 0),
                        child: _hasSelectIcon
                            ? InkWell(
                                onTap: (() {
                                  if (widget.onChangedCallback != null) {
                                    widget.onChangedCallback();
                                  }
                                  setState(() {
                                    WidgetsBinding.instance.addPostFrameCallback(
                                        (_) => widget.controller.clear());

                                    ///直接使用此方法会抛出异常，但是不会闪退，使用上面方法会导致出现一个水滴
//                                    widget.controller.text = '';
                                    _hasSelectIcon = false;
                                  });
                                }),
                                child: Icon(
                                  Icons.cancel,
                                  size: 24.0,
                                  color: widget.prefixIconColor,
                                ),
                              )
                            : Text(""),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(-10, 4, 0, 4),
                      filled: true,
                      fillColor: widget.editTextBackgroudColor,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(
                            color: widget.editTextBackgroudColor, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(
                            color: widget.editTextBackgroudColor, width: 1),
                      ),
                    ),
                    onChanged: (str) {
                      if (widget.onChangedCallback != null) {
                        widget.onChangedCallback();
                      }
                      setState(() {
                        if (str.isEmpty) {
                          _hasSelectIcon = false;
                        } else {
                          _hasSelectIcon = true;
                        }
                      });
                    },
                    onSubmitted: (content) {
                      widget.onSearchCallback(content);
                    },
                    onEditingComplete: widget.onEditingComplete,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
