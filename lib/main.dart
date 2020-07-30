import 'package:flutter/material.dart';
import './config/index.dart';

import 'package:provide/provide.dart';
import './provide/currnet_index_provide.dart';
import './pages/logins/login_page.dart';

void main(){
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();
  providers
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));

  runApp(ProviderNode(child: MyApp(),providers: providers));
}
///Users/lihaitao
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
          title: KString.mainTitle,//通用主标题
          debugShowCheckedModeBanner: true,
          //主题
          theme: ThemeData(
            primaryColor: KColor.primaryColor,
          ),
          home:  LoginPage()
      )
    );
  }
}