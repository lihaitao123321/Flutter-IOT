import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:charge/config/color.dart';

class KToast {
  KToast();

  ///打开loading
  void success(text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: KColor.loadingColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void error(text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: KColor.errorColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void warning(text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: KColor.warningColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
