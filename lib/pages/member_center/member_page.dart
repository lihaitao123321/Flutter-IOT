import 'package:charge/config/index.dart';
import 'package:charge/provide/theme_provide.dart';
import 'package:charge/components/cell.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class MemberPage extends StatefulWidget {
  _MemberPageState createState() => _MemberPageState();
  final dataList = [
    {
      "icon": 'asset/images/member/compony.png',
      "title": '切换企业',
      "desc": '南京瑞德恩科技有限公司',
      "isLink": true
    },
    {
      "icon": 'asset/images/member/lock.png',
      "title": '修改密码',
      "desc": '',
      "isLink": true
    },
    {
      "icon": 'asset/images/member/message.png',
      "title": '消息设置',
      "desc": '',
      "isLink": true
    },
    {
      "icon": 'asset/images/member/language.png',
      "title": '语言类型',
      "desc": '',
      "isLink": true
    },
    {
      "icon": 'asset/images/member/clean.png',
      "title": '清除缓存',
      "desc": '',
      "isLink": true
    },
    {
      "icon": 'asset/images/member/version.png',
      "title": '版本介绍',
      "desc": '',
      "isLink": true
    },
    {
      "icon": 'asset/images/member/aboutUs.png',
      "title": '关于我们',
      "desc": '',
      "isLink": true
    },
  ];
}

class _MemberPageState extends State<MemberPage> {
  Widget build(BuildContext context) {
    return ProvideMulti(
        requestedValues: [ThemeProvide],
        builder: (context, child, model) {
          return Scaffold(
            backgroundColor: KColor.backgroundColor,
            body: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // var data = json.decode(snapshot.data.toString());
                }
                return Container(
                    child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                  UserInfoWidget(),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: Colors.white),
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: CellGroups(
                          dataList: widget.dataList,
                          text: "test title",
                          icon: "asset/images/mark.png",
                          textColor: Color.fromRGBO(51, 51, 51, 1),
                          onTab: () {
                            print("test");
                          }))
                ])));
              },
            ),
          );
        });
  }
}

/// 顶部用户信息
class UserInfoWidget extends StatefulWidget {
  _UserInfoWidget createState() => _UserInfoWidget();
}

class _UserInfoWidget extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return ProvideMulti(
        requestedValues: [ThemeProvide],
        builder: (context, child, model) {
          Map currentTheme = Provide.value<ThemeProvide>(context).currentTheme;
          return Container(
            height: 210,
            decoration: BoxDecoration(color: currentTheme["primaryColor"]),
          );
        });
  }
}
