import 'package:flutter/material.dart';

class KRouteAnimate extends PageRouteBuilder {
  final Widget pageWidget;

  KRouteAnimate(this.pageWidget)
      : super(
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
              return pageWidget;
            },
            transitionsBuilder:
                (BuildContext context, Animation<double> animation1, Animation<double> animation2, Widget child) {
              //组合动画，旋转、缩放、渐变
              return RotationTransition(
                child: ScaleTransition(
                  child: FadeTransition(
                    child: child,
                    opacity:
                        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation1, curve: Curves.easeIn)),
                  ),
                  scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation1, curve: Curves.easeIn)),
                ),
                turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation1, curve: Curves.easeIn)),
              );
            });
}
