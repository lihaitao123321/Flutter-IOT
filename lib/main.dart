import 'dart:io';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:charge/config/amap.dart';
import 'package:charge/app.dart';
import 'package:charge/router/routers_define.dart';
import 'package:charge/tools/permission.dart';
import 'package:charge/tools/spUtil.dart';
import 'package:charge/util/global.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import './provide/index.dart';
import 'package:flutter/services.dart';

// ignore: missing_return
Future<void> main() {
  FluroRouter router = FluroRouter();
  // 注册路由
  Routes.configureRoutes(router);
  Routes.router = router;
  Application.router = router;
  realRunApp();
}

void realRunApp() async {
  //如果需要在runapp之前初始化其它模块
  WidgetsFlutterBinding.ensureInitialized();
  // 禁用多余的log
  await enableFluttifyLog(false);
  //初始化本地储存同步方法
  await SpUtil.initInstance();
  // 获取prodives
  Providers providers = IndexProvide.initProvide();
  runApp(ProviderNode(child: MyApp(), providers: providers));
  // 状态栏设置
  if (Platform.isAndroid) {
    // 这一步设置状态栏颜色为透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }
  //高德地图初始化-ios
  await AmapService.init(iosKey: KMap.iosKey, androidKey: KMap.androidKey, webApiKey: KMap.webApiKey);
  // 请求权限
  KPermission.requestPermission();
}
