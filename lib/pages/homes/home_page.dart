import 'package:charge/provide/theme_provide.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../config/index.dart';
import 'package:charge/pages/homes/home_search.dart';
import './components/searchBar.dart';
import './components/wrapBlock.dart';
import 'components/barChart.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map> blockDataList = [
    {
      "value": 1,
      "label": "项目数量",
      "unit": "(座)",
      "icon": "",
    },
    {
      "value": 6,
      "label": "项目数量",
      "unit": "(座)",
      "icon": "",
    },
    {
      "value": 1,
      "label": "项目数量",
      "unit": "(座)",
      "icon": "",
    },
    {
      "value": 6,
      "label": "项目数量",
      "unit": "(座)",
      "icon": "",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return ProvideMulti(
        requestedValues: [ThemeProvide],
        builder: (context, child, model) {
          return Scaffold(
            // appBar: serachBar(context),
            appBar: AppBar(
              leading: Icon(Icons.apps),
              title: serachBar(context, '某某智能运维云服务系统', () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => HomeSearchPage()));
              }),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.camera),
                    onPressed: () {
                      model.get<ThemeProvide>().changeTheme(2);
                    })
              ],
            ),
            backgroundColor: KColor.backgroundColor,
            body: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // var data = json.decode(snapshot.data.toString());
                }
                return Container(
                    child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                  warpBlockList(context, blockDataList),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                          child: barChart([36, 62, 29, 40]),
                          height: 281,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          )))
                ])));
              },
            ),
          );
        });
  }
}
