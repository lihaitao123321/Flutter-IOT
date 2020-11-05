import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Application {
  static FluroRouter router;
  static BuildContext appContext; // 顶层content
  static getTypeName(dynamic obj) {
    String type = "";
    if (obj is int) {
      type = 'int';
    } else if (obj is String) {
      type = 'String';
    } else if (obj is bool) {
      type = 'bool';
    } else if (obj is Map) {
      type = 'Map';
    }
    return type;
  }
}
