import 'package:flutter/material.dart';
import '../../config/index.dart';
import 'dart:convert';
class HomeSearchPage extends StatefulWidget{
  _HomeSearchPageState createState() => _HomeSearchPageState();
}
class _HomeSearchPageState extends State<HomeSearchPage>{
  @override
  Widget build(BuildContext context) {
    // super.build(context);
//    FormData formData = new FormData.from({
//      "mobile": "13981983532",
//      "pwd": "983532",
//    });
    return Scaffold(
      appBar: AppBar(
        title:Container(
          height: 30,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(13, 0, 10, 0),
                child: Icon(Icons.search,size: 18)
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none
                    ),
                    style: TextStyle(fontSize: 13,color: Color.fromRGBO(255, 255, 255, 0.7)),
                    enabled: false,
                    controller: TextEditingController.fromValue(TextEditingValue(text: '某某智能运维云服务系统')),
                    onTap: () {
                      Navigator.push(context,new MaterialPageRoute(builder: (context) => new HomeSearchPage()));
                    },
                  ),
                ),
              )
          ])
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              
            }
          )
        ],
      ),
      backgroundColor: KColor.backgroundColor,
      body: FutureBuilder(
        builder: (context, snapshot){
          if(snapshot.hasData){
              var data = json.decode(snapshot.data.toString());
              print(data);
          }
          return Container(child: Text('这时搜索页面'));
        },
      ),
    );
  }
}