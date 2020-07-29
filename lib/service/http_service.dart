import 'package:dio/dio.dart';
import 'dart:async';
import '../config/index.dart';
import '../tools/index_tools.dart';
Future request(serveName, {formData})async{
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
    String pwd = await KRsa.encryption('11076038');
    var postData = {
      "telephone": "15051665680",
      "passwd": pwd
    };
    response = await dio.post(url,data: postData);
    if(response.statusCode == 200){
      return response;
    }else{
      throw Exception('请求失败');
    }
  } catch (e) {
    throw Exception('后台请求异常...');
  }
}