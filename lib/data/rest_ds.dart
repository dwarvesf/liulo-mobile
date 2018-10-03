import 'dart:async';

import 'package:liulo/model/response/login_response.dart';
import 'package:liulo/utils/network_util.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://192.168.40.157:4000/api/v1";
  static final LOGIN_URL = BASE_URL + "/login_google";

  Future<LoginResponse> login(String token, String provider) {
    return _netUtil.post(LOGIN_URL,
        body: {"provider": provider, "access_token": token}).then((
        dynamic res) {
      print(res.toString());
      if (res["error"] != null && res["error"]) throw new Exception(
          res["error_msg"]);
      var loginResponse = new LoginResponse();
      loginResponse = LoginResponse.fromJson(res);
      if (loginResponse != null)
        return loginResponse;
    });
  }
}
