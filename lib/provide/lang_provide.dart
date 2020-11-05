import 'package:flutter/material.dart';
import '../tools/localStorage.dart';

class LangProvide with ChangeNotifier {
  String currentLangValue = 'zh';
  List<Map> langSelectList = [
    {"label": '中文', "value": 'zh_CN'},
    {"label": 'English', "value": 'en'},
  ];

  /// 改变主题
  changeLang(String value) {
    currentLangValue = value;
    for (int i = 0; i < langSelectList.length; i++) {
      if (langSelectList[i]['value'] == value) {
        currentLangValue = langSelectList[i]['value'];
      }
    }
    setLocalStorage('lastLangValue', currentLangValue);
    notifyListeners();
  }
}
