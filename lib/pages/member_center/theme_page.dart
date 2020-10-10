import 'package:charge/provide/theme_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class ThemePage extends StatefulWidget {
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State {
  bool check = false;
  String _themeValue = '0';
  void _toggleThemeChange(value) {
    setState(() {
      _themeValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    String currentThemeValue =
        Provide.value<ThemeProvide>(context).currentThemeValue;
    _toggleThemeChange(currentThemeValue);
    return ProvideMulti(
        requestedValues: [ThemeProvide],
        builder: (context, child, model) {
          List<Map> themeSelectList =
              Provide.value<ThemeProvide>(context).themeSelectList;
          List<Widget> themeList = [];
          themeSelectList.forEach((element) {
            themeList.add(RadioListTile(
              value: element['value'],
              title: Text(element['label']),
              groupValue: _themeValue,
              secondary: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(color: element['color'])),
              onChanged: (value) {
                model.get<ThemeProvide>().changeTheme(element['value']);
                _toggleThemeChange(value);
              },
            ));
          });
          return Scaffold(
            appBar: AppBar(title: Text('主题颜色')),
            body: Column(children: themeList),
          );
        });
  }
}
