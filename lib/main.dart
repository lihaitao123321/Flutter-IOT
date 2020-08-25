import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:charge/config/amap.dart';
import 'package:flutter/material.dart';
import './config/index.dart';
import 'package:provide/provide.dart';
import './provide/currnet_index_provide.dart';
import './pages/logins/login_page.dart';

Future<void> main() async {
  //shouye
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();
  providers..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers));
  //高德地图初始化-ios
  await enableFluttifyLog(false);
  await AmapService.init(
      iosKey: KMap.iosKey,
      androidKey: KMap.androidKey,
      webApiKey: KMap.webApiKey);
}

///Users/lihaitao
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialApp(
            title: KString.mainTitle, //通用主标题
            debugShowCheckedModeBanner: true,
            //主题
            theme: ThemeData(
              primaryColor: KColor.primaryColor,
            ),
            home: LoginPage()));
  }
}
