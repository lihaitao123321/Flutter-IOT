import 'package:charge/config/index.dart';
import 'package:charge/pages/category_page.dart';
import 'package:flutter/material.dart';
import './homes/home_page.dart';//首页
import 'category_page.dart';//分类
import 'cart_page.dart';//购物车
import 'member_page.dart';//会员中心
import 'package:provide/provide.dart';
import '../provide/currnet_index_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class IndexPage extends StatelessWidget{
  final List<BottomNavigationBarItem> bottomTabs = [
    //首页
    BottomNavigationBarItem(
      title: Text(KString.homeTitle),//首页
      icon: Icon(Icons.home)
    ),
    BottomNavigationBarItem(
      title: Text(KString.categoryTitle),//分类
      icon: Icon(Icons.category)
    ),
    BottomNavigationBarItem(
      title: Text(KString.shoppingCartTitle),//购物车
      icon: Icon(Icons.shopping_cart)
    ),
    BottomNavigationBarItem(
      title: Text(KString.memberTitle),//会员中心
      icon: Icon(Icons.person)
    ),
  ];
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Provide<CurrentIndexProvide>(
      builder: (context, child, val){
        //取到当前索引值
        int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
            backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              items: bottomTabs,
              onTap: (index){
                Provide.value<CurrentIndexProvide>(context).changeIndex(index);
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