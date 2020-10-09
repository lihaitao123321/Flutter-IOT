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
      dataList.forEach((element) {
        list.add(Container(
            height: 55,
            // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
                color: bgColor,
                border: Border(
                    bottom: BorderSide(
                        style: BorderStyle.solid,
                        width: 0.5,
                        color: Color.fromRGBO(0, 0, 0, 0.1)))),
            child: Material(
              color: bgColor,
              child: InkWell(
                onTap: onTab,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.asset(element["icon"], width: 13),
                    Padding(padding: EdgeInsets.only(left: 16)),
                    Text(element["title"],
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: textColor)),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                    Icon(Icons.keyboard_arrow_right, color: textColor)
                  ],
                ),
              ),
            )));
      });
    }
    return Container(child: Column(children: list));
  }
}
