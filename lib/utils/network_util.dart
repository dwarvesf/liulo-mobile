import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = JsonDecoder();

  final Dio dio = Dio();

  Future<dynamic> get(String url, {Map headersGet, body}) {
    return http.get(url, headers: headersGet).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {Map headers, body}) async {
    return await http.post(url, body: body, headers: headers).then((http.Response response) {
      print(response.body);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(response.body);
    });
  }

  Future<Response<dynamic>> uploadFile(String url, String filePath, String fieldName, {Map headers, body}) async {
    File file = File(filePath);
    Map<String, dynamic> formData = {};
    formData[fieldName] = UploadFileInfo(file, basename(file.path));
    if (body != null) formData.addAll(body);
    return await dio.post(url, data: FormData.from(formData));
  }
}
