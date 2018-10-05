import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class TokenUtil {
  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token') ?? "";
    return token;
  }

  static Future<Null> setUserLocal(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
