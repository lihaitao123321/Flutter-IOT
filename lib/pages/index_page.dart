import 'package:charge/config/index.dart';
import 'package:flutter/material.dart';
import './homes/home_page.dart'; //首页
import './maps/map.dart'; //地图
import 'cart_page.dart'; //购物车
import 'member_center/member_page.dart'; //会员中心
import 'package:provide/provide.dart';
import '../provide/currnet_index_provide.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        label: KString.homeTitle, //首页
        icon: Icon(Icons.home)),
    BottomNavigationBarItem(
        label: KString.mapTitle, //地图
        icon: Icon(Icons.location_on)),
    BottomNavigationBarItem(
        label: KString.shoppingCartTitle, //购物车
        icon: Icon(Icons.shopping_cart)),
    BottomNavigationBarItem(
        label: KString.memberTitle, //会员中心
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
