import 'package:charge/tools/spUtil.dart';
import 'package:charge/util/global.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../config/index.dart';
import 'dart:convert' show json;
import 'dart:io';

Future<Map> request(serveName, formData) async {
  try {
    String token = SpUtil.preferences.getString("token");
    if (token == null) {
      token = "";
    }
    Dio dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 30000,
      headers: {"Authorization": token},
      contentType: Headers.jsonContentType,
      responseType: ResponseType.plain,
    ));
    String url = SERVICE_PATH[serveName];
    Response response = await dio.post(url, data: formData);
    if (response.statusCode == HttpStatus.ok) {
      Map data = json.decode(response.data.toString());
      return data;
    }
    return {};
  } catch (e) {
    if (e.response.statusCode == 401) {
      Application.router.navigateTo(Application.appContext, '/login');
    }
    // throw Exception('后台请求异常...');
  }
}
