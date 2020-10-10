import 'package:flutter/material.dart';
import '../config/color.dart';
import '../tools/localStorage.dart';

class ThemeProvide with ChangeNotifier {
  String currentThemeValue = '0';
  Map currentTheme = {"primaryColor": KColor.primaryColor};
  List<Map> themeSelectList = [
    {"label": '屎黄色', "color": Color.fromRGBO(132, 95, 63, 1.0), "value": '0'},
    {"label": '蓝色', "color": Colors.blue, "value": '1'},
    {"label": '红色', "color": Colors.red, "value": '2'},
  ];

  /// 改变主题
  changeTheme(String value) {
    currentThemeValue = value;
    for (int i = 0; i < themeSelectList.length; i++) {
      if (themeSelectList[i]['value'] == value) {
        currentTheme = themeSelectList[i];
      }
    }
    setLocalStorage('lastThemeValue', currentThemeValue);
    notifyListeners();
  }
}
