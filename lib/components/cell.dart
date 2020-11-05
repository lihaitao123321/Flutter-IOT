import 'package:charge/tools/routerAnimate.dart';
import 'package:charge/util/global.dart';
import 'package:flutter/material.dart';

class CellGroups extends StatelessWidget {
  CellGroups(
      {Key key,
      this.text,
      this.textColor: Colors.black,
      this.onTab,
      this.icon,
      this.dataList,
      this.bgColor: Colors.white})
      : super(key: key);

  final List<Map> dataList;
  final Function onTab;
  final String icon;
  final String text;
  final Color textColor;
  final Color bgColor;

  Widget build(BuildContext context) {
    List<Widget> list = [];
    if (dataList != null) {
      for (int i = 0; i < dataList.length; i++) {
        Map element = dataList[i];
        bool isFirst = i == 0;
        bool isLast = i == (dataList.length - 1);
        BorderRadius borderStyle;
        if (isFirst && isLast) {
          borderStyle = BorderRadius.all(Radius.circular(6));
        } else if (isFirst) {
          borderStyle = BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6));
        } else if (isLast) {
          borderStyle = BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6));
        }
        BorderSide borderline;
        if (!isLast) {
          borderline = BorderSide(style: BorderStyle.solid, width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.1));
        } else {
          borderline = BorderSide(style: BorderStyle.none);
        }
        Widget icon;
        if (element["isLink"]) {
          icon = Icon(Icons.keyboard_arrow_right, color: textColor);
        } else {
          icon = Container();
        }
        list.add(Container(
            height: 55,
            child: Material(
              color: bgColor,
              borderRadius: borderStyle,
              child: InkWell(
                onTap: () {
                  if (element["linkPage"] != null) {
                    Application.router.navigateTo(context, element["linkPage"]);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 16)),
                    Expanded(
                      child: Container(
                          height: 55,
                          decoration: BoxDecoration(border: Border(bottom: borderline)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Image.asset(element["icon"], width: 13),
                                Padding(padding: EdgeInsets.only(left: 16)),
                                Text(element["title"],
                                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: textColor)),
                                Expanded(child: Container(), flex: 1),
                                icon,
                              ])),
                      flex: 1,
                    ),
                    Padding(padding: EdgeInsets.only(left: 16)),
                  ],
                ),
              ),
            )));
      }
    }
    return Container(child: Column(children: list));
  }
}
