import 'dart:convert';
import 'package:charge/config/color.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{

    _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.backgroundColor,
      appBar: new AppBar(
        title: Text('登录'),
      ),
      body: FutureBuilder(
        // future: request('login'),//接口调用
        builder: (context, snapshot){
          if(snapshot.hasData){
              var data = json.decode(snapshot.data.toString());
              // print(data);
          }
          final controller = TextEditingController();
          controller.addListener(() {
            print('input ${controller.text}');
          });
          final controller1 = TextEditingController();
          controller1.addListener(() {
            print('input ${controller.text}');
          });
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 250,
                  child: Center(
                    child: Image(
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      image: AssetImage('asset/images/girl.jpeg')
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(38, 0, 38, 0),
                  child: Container(

                    child: Column(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                style: BorderStyle.solid,
                                width: 1,
                                color: Color.fromRGBO(0, 0, 0, 0.1)
                              ),
                            )
                        ),
                        child: Row(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 23, 0),
                            child: Icon(Icons.phone_iphone)
                          ),
                          Expanded(child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.blue,
                              labelText: '请输入手机号',
                              border: InputBorder.none,///去掉下划线
                            ),
                            autofocus: false,
                            controller: controller,
                            onChanged: (text) {//内容改变的回调
                              print('change $text');
                            },
                            onSubmitted: (text) {//内容提交(按回车)的回调
                              print('submit $text');
                            },
                          ))
                        ])
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                              style: BorderStyle.solid,
                              width: 1,
                              color: Color.fromRGBO(0, 0, 0, 0.1)
                            ),
                          )
                        ),
                        child: Row(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 23, 0),
                            child: Icon(Icons.lock)
                          ),
                          Expanded(child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.blue,
                              labelText: '请输入密码',
                              border: InputBorder.none,///去掉下划线
                            ),
                            autofocus: false,
                            controller: controller1,
                            onChanged: (text) {//内容改变的回调
                              print('change $text');
                            },
                            onSubmitted: (text) {//内容提交(按回车)的回调
                              print('submit $text');
                            },
                          ))
                        ])
                      ),
                  ]))
                ),
              ],
            )
          );
        },
      ),
    );
  }

}
