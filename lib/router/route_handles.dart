import 'package:charge/pages/member_center/lang_page.dart';
import 'package:charge/pages/member_center/theme_page.dart';
import 'package:charge/pages/videos/video_detial_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:charge/pages/index_page.dart';
import 'package:charge/pages/logins/login_page.dart';

var loginHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return LoginPage();
});
var indexHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return IndexPage();
});
var videoDetialHandler = new Handler(handlerFunc: (BuildContext context, Map params) {
  return VideoDetial(id: params["id"]);
});
var langHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return LangPage();
});
var themeHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return ThemePage();
});
