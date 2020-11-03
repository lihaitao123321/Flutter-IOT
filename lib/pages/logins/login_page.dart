import 'package:charge/provide/theme_provide.dart';
import 'package:flutter/material.dart';
import 'package:charge/config/color.dart';
import 'package:charge/service/http_service.dart';
import 'package:charge/tools/tools.dart';
import 'package:charge/components/loading.dart';
import 'package:charge/components/toast.dart';
import 'package:charge/pages/index_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phone = '17630378060';
  String pwd = '123321';

  void _togglePhoneChange(text) {
    setState(() {
      phone = text;
    });
  }

  void _togglePasswordChange(text) {
    setState(() {
      pwd = text;
    });
  }

  void _login() async {
    Loading loading = Loading(context);
    loading.show();
    String password = await KRsa.encryption(pwd);
    // ignore: missing_return
    request('login', {"telephone": phone, "passwd": password}).then((data) {
      loading.close();
      if (data['status'] == "1") {
        KToast.error("账号或密码错误");
        return false;
      }
      if (data['num'] == "0") {
        KToast.warning("当前用户未绑定所属公司，请联系管理员!");
        return false;
      } else if (data['num'] == "1") {
        setLocalStorage('userInfo', data);
        setLocalStorage('token', data["token"]);
        KToast.success("登录成功");
        Future.delayed(Duration(milliseconds: 1000), () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new IndexPage()));
        });
      } else {
        KToast.error("登录异常，请稍后再试");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return ProvideMulti(
        requestedValues: [ThemeProvide],
        builder: (context, child, model) {
          Map currentTheme = Provide.value<ThemeProvide>(context).currentTheme;
          return Scaffold(
            backgroundColor: KColor.backgroundColor,
            resizeToAvoidBottomPadding: false, //输入框抵住键盘
            // appBar: new AppBar(
            //   title: Text('登录'),
            // ),
            body: FutureBuilder(
              // future: request('login'),//接口调用
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // var data = json.decode(snapshot.data.toString());
                }

                return Container(
                    child: Column(
                  children: <Widget>[
                    Container(
                      height: 260,
                      child: Center(
                        child: Image(
                            width: 100, height: 100, fit: BoxFit.cover, image: AssetImage('asset/images/girl.jpeg')),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(38, 0, 38, 0),
                        child: Container(
                            child: Column(children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(style: BorderStyle.solid, width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
                              )),
                              child: Row(children: <Widget>[
                                Padding(padding: EdgeInsets.fromLTRB(0, 0, 23, 0), child: Icon(Icons.phone_iphone)),
                                Expanded(
                                    child: TextField(
                                        decoration: InputDecoration(
                                          fillColor: Colors.blue,
                                          labelText: '请输入手机号',
                                          border: InputBorder.none,
                                        ),
                                        autofocus: false,
                                        onChanged: (text) {
                                          _togglePhoneChange(text);
                                        },
                                        controller:
                                            TextEditingController.fromValue(TextEditingValue(text: this.phone))))
                              ])),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(style: BorderStyle.solid, width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
                              )),
                              child: Row(children: <Widget>[
                                Padding(padding: EdgeInsets.fromLTRB(0, 0, 23, 0), child: Icon(Icons.lock)),
                                Expanded(
                                    child: TextField(
                                        decoration: InputDecoration(
                                          fillColor: Colors.blue,
                                          labelText: '请输入密码',
                                          border: InputBorder.none,
                                        ),
                                        autofocus: false,
                                        onChanged: (text) {
                                          _togglePasswordChange(text);
                                        },
                                        controller: TextEditingController.fromValue(TextEditingValue(text: this.pwd))))
                              ])),
                          Container(
                              width: 400,
                              height: 44,
                              margin: EdgeInsets.fromLTRB(0, 55, 0, 0),
                              child: RaisedButton(
                                color: currentTheme['color'],
                                textColor: Colors.white,
                                child: Text('登录'),
                                onPressed: () => {_login()},
                              )),
                          Container(
                              width: 400,
                              margin: EdgeInsets.fromLTRB(0, 26, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '忘记密码？',
                                    style: new TextStyle(color: KColor.disabledColor),
                                  ),
                                  Text(
                                    '新用户注册>',
                                    style: new TextStyle(color: KColor.primaryColor),
                                  )
                                ],
                              ))
                        ]))),
                  ],
                ));
              },
            ),
          );
        });
  }
}
