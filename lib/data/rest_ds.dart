import 'dart:async';

import 'package:liulo/model/user.dart';
import 'package:liulo/utils/network_util.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://192.168.40.157:4000";
  static final LOGIN_URL = BASE_URL + "/api/v1/users";

  Future<User> login(String token, String provider) {
    return _netUtil.post(LOGIN_URL,
        body: {"provider": provider, "token": token}).then((dynamic res) {
      print(res.toString());
      if (res["error"]) throw new Exception(res["error_msg"]);
      return new User.map(res["user"]);
    });
  }
}
