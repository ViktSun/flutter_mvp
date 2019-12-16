import 'package:flutter/cupertino.dart';
import 'package:flutter_mvp/res/colors.dart';

class HomeItemTitle extends StatelessWidget {
  final String title;
  final AnimationController animationController;
  final Animation animation;

  const HomeItemTitle(this.title, {Key key,this.animationController,this.animation}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context,child){
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 100*(1.0-animation
                .value), 0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 1.0,
                  width: double.infinity,
                  color: MColors.gray_ee,
                ),
                Container(
                  color: MColors.white,
                  height: 46.0,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                        title,
                        style: TextStyle(color: MColors.text_dark, fontSize: 16.0,fontStyle:
                        FontStyle.normal,fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
