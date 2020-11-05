import 'package:charge/config/index.dart';
import 'package:charge/provide/theme_provide.dart';
import 'package:charge/components/cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class MemberPage extends StatefulWidget {
  _MemberPageState createState() => _MemberPageState();
  final dataList = [
    {
      "icon": 'asset/images/member/compony.png',
      "title": '切换企业',
      "desc": '南京瑞德恩科技有限公司',
      "isLink": false,
    },
    {"icon": 'asset/images/member/lock.png', "title": '修改密码', "desc": '', "isLink": true},
    {"icon": 'asset/images/member/message.png', "title": '消息设置', "desc": '', "isLink": true},
    {"icon": 'asset/images/member/language.png', "title": '语言类型', "desc": '', "isLink": true, "linkPage": '/lang'},
    {"icon": 'asset/images/member/language.png', "title": '主题颜色', "desc": '', "isLink": true, "linkPage": '/theme'},
    {"icon": 'asset/images/member/clean.png', "title": '清除缓存', "desc": '', "isLink": true},
    {"icon": 'asset/images/member/version.png', "title": '版本介绍', "desc": '', "isLink": true},
    {"icon": 'asset/images/member/aboutUs.png', "title": '关于我们', "desc": '', "isLink": true},
  ];
}

class _MemberPageState extends State<MemberPage> {
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
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
                return Stack(alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                    children: <Widget>[
                      UserInfoWidget(),
                      _CellGroups(dataList: widget.dataList),
                    ]);
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
          return Positioned(
            top: 0,
            right: 0,
            left: 0,
            height: 210,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
              height: 210,
              decoration: BoxDecoration(color: currentTheme["color"]),
              child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          // 圆形图片
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=388255163,2500419124&fm=11&gp=0.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Expanded(
                        flex: 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text('李海涛',
                                          style: TextStyle(
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold))),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text('某某某科技有限公司',
                                      style: TextStyle(
                                          color: Color.fromRGBO(255, 255, 255, 0.7),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold))),
                            ])),
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Icon(Icons.keyboard_arrow_right, color: Colors.white30, size: 30)),
                  ])),
            ),
          );
        });
  }
}

class _CellGroups extends StatelessWidget {
  // 接收父级参数定义
  final List<Map> dataList;
  // 构造函数
  _CellGroups({Key key, this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 0,
        left: 0,
        top: 155,
        child: Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: CellGroups(
                dataList: dataList,
                text: "test title",
                icon: "asset/images/mark.png",
                textColor: Color.fromRGBO(51, 51, 51, 1),
                onTab: () {
                  print("test");
                })));
  }
}
