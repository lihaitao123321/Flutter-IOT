import 'package:flutter/material.dart';
import '../index_page.dart';//首页
class LoginPage extends StatefulWidget{
    _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new RaisedButton(
          child: new Text('Launch second screen'),
          onPressed: (){
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new IndexPage(),
              ),
            );
          },
      ),
    );
  }
  
}