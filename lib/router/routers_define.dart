import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'route_handles.dart';

class Routes {
  static FluroRouter router;
  // 路由管理
  static FluroRouter configureRoutes(FluroRouter router) {
    router.define(
      '/',
      handler: indexHandler,
    ); //默认页面(index)
    router.define('/login', handler: loginHandler); //登录
    router.define('/video_detial', handler: videoDetialHandler); //视频详情
    router.define('/lang',
        handler: langHandler, transitionType: TransitionType.custom, transitionBuilder: tBuilder); //语言设置
    router.define('/theme', handler: themeHandler); //主题设置
    router.notFoundHandler = indexHandler; //空页面
    return router;
  }

  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配
  static Future navigateTo(BuildContext context, String path,
      {Map<String, dynamic> params, TransitionType transition = TransitionType.native}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    path = path + query;
    return router.navigateTo(context, path, transition: transition);
  }
}

// 动画效果1
Widget tBuilder(BuildContext context, Animation<double> animation1, Animation<double> animation2, Widget child) {
  //组合动画，旋转、缩放、渐变
  return RotationTransition(
    child: ScaleTransition(
      child: FadeTransition(
        child: child,
        opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation1, curve: Curves.easeIn)),
      ),
      scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation1, curve: Curves.easeIn)),
    ),
    turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation1, curve: Curves.easeIn)),
  );
}
