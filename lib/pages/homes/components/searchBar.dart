import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SearchBar extends State {
//     // props 从 widget.xxx 获取
//     @override
//     Widget build(BuildContext context) => new Center(
//         child: new Column(
//             children: <Widget>[
//                 new Text(widget.title),
//                 new FlatButton(child: const Text('Press'), onPressed: widget.onPress),
//             ],
//         ),
//     );
// }
Widget serachBar(context,[String text,Function onTap]) {
  return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.3),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child:GestureDetector(
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(13, 0, 10, 0),
              child: Icon(Icons.search, size: 18)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none),
                style: TextStyle(
                    fontSize: 13, color: Color.fromRGBO(255, 255, 255, 0.7)),
                // enabled: false,
                readOnly: true,
                controller: TextEditingController.fromValue(
                    TextEditingValue(text: text)),
                onTap: onTap,
              ),
            ),
          )
        ]),
        onTap: onTap,
      ),
    );
}
