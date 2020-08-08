import 'package:dio/dio.dart';
import 'dart:async';
import '../config/index.dart';
import 'dart:convert';
import 'dart:io';

Future<Response> request(serveName, formData) async {
  try {
    Response response;
    Dio dio = Dio(BaseOptions(
      baseUrl: '',
      connectTimeout: 5000,
      receiveTimeout: 30000,
      headers: {
        "Authorization": '',
      },
      contentType: Headers.jsonContentType,
      responseType: ResponseType.plain,
    ));
    String url = BASE_URL + servicePath[serveName];
    response = await dio.post(url, data: formData);
    if (response.statusCode == HttpStatus.ok) {
      var data = jsonDecode(response.data.toString());
      print(data);
      return response;
    } else {
      throw Exception('请求失败');
    }
  } catch (e) {
    throw Exception('后台请求异常...');
  }
}
