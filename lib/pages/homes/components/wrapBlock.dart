import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget warpBlockList(context, List<Map> dataList) {
  List<Widget> warpList = [];
  for (int i = 0; i < dataList.length; i++) {
    warpList.add(warpBlockItem(context, dataList[i]));
  }
  return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Wrap(spacing: 15, runSpacing: 15, children: warpList));
}

Widget warpBlockItem(context, Map item, [Function onTap]) {
  return Container(
      width: 165,
      padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: GestureDetector(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.map),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: Row(
                children: <Widget>[
                  Text(item["label"],
                      style: TextStyle(
                          color: Color.fromRGBO(119, 119, 119, 1),
                          fontSize: 13)),
                  Text(
                    item["unit"],
                    style: TextStyle(color: Color.fromRGBO(190, 190, 190, 1)),
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(item["value"].toString(),
                  style: TextStyle(
                      color: Color.fromRGBO(43, 127, 242, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold))),
        ],
      )));
}
