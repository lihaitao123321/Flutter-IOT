import 'package:charge/config/index.dart';
import 'package:flutter/material.dart';
import './homes/home_page.dart'; //首页
import './maps/map.dart'; //地图
import 'cart_page.dart'; //购物车
import 'member_page.dart'; //会员中心
import 'package:provide/provide.dart';
import '../provide/currnet_index_provide.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    //首页
    BottomNavigationBarItem(
        title: Text(KString.homeTitle), //首页
        icon: Icon(Icons.home)),
    BottomNavigationBarItem(
        title: Text(KString.mapTitle), //地图
        icon: Icon(Icons.location_on)),
    BottomNavigationBarItem(
        title: Text(KString.shoppingCartTitle), //购物车
        icon: Icon(Icons.shopping_cart)),
    BottomNavigationBarItem(
        title: Text(KString.memberTitle), //会员中心
        icon: Icon(Icons.person)),
  ];
  final List<Widget> tabBodies = [
    HomePage(),
    MapPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    return ProvideMulti(
      requestedValues: [CurrentIndexProvide],
      builder: (context, child, model) {
        // getLocalStorage('userInfo').then((data) {
        //   print('userInfo' + data.toString());
        // });
        // getLocalStorage('lastThemeIndex').then((data) {
        //   print('lastThemeIndex' + data.toString());
        // });
        //取到当前索引值
        int currentIndex = model.get<CurrentIndexProvide>().currentIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index) {
              model.get<CurrentIndexProvide>().changeIndex(index);
            },
          ),
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
        );
      },
    );
  }
}
