import 'package:charge/tools/spUtil.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../config/index.dart';
import 'dart:convert' show json;
import 'dart:io';

Future<Map> request(serveName, formData) async {
  try {
    String token = SpUtil.preferences.getString("token");
    print(token);
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
    } else {
      throw Exception('请求失败');
    }
  } catch (e) {
    throw Exception('后台请求异常...');
  }
}
