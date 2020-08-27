import 'package:flutter/material.dart';
import '../config/color.dart';
import '../tools/localStorage.dart';

class ThemeProvide with ChangeNotifier {
  int currentIndex = 1;
  Map currentTheme = {"primaryColor": KColor.primaryColor};
  List<Map> themeSelectList = [
    {"label": '屎黄色', "value": Color.fromRGBO(132, 95, 63, 1.0), "index": 1},
    {"label": '蓝色', "value": Colors.blue, "index": 2},
    {"label": '红色', "value": Colors.red, "index": 3},
  ];

  /// 改变主题
  changeTheme(int index) {
    currentIndex = index;
    if (currentIndex == 1) {
      currentTheme = {"primaryColor": KColor.primaryColor};
    } else if (currentIndex == 2) {
      currentTheme = {"primaryColor": Colors.blue};
    } else if (currentIndex == 3) {
      currentTheme = {"primaryColor": Colors.red};
    }
    setLocalStorage('lastThemeIndex', currentIndex.toString());
    notifyListeners();
  }
}
