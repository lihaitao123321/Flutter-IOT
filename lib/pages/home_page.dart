import 'package:flutter/material.dart';
import '../config/index.dart';
import '../service/http_service.dart';
import 'dart:convert';
class HomePage extends StatefulWidget{
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    // super.build(context);
//    FormData formData = new FormData.from({
//      "mobile": "13981983532",
//      "pwd": "983532",
//    });
    return Scaffold(
      backgroundColor: KColor.backgroundColor,
      body: FutureBuilder(
        future: request('login'),
        builder: (context, snapshot){
          if(snapshot.hasData){
              var data = json.decode(snapshot.data.toString());
              print(data);
          }
          return Container(child: Text('666'));
        },
      ),
    );
  }
}