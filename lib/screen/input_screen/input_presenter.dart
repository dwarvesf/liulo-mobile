import 'dart:convert';

import 'package:liulo/data/rest_ds.dart';
import 'package:liulo/model/response/login_response.dart';

abstract class InputScreenContract {
  void onLoginSuccess(LoginResponse loginReponse);

  void onLoginError(String errorTxt);
}

class InputPresenter {
  InputScreenContract _view;
  RestDatasource api = new RestDatasource();

  InputPresenter(this._view);

  doLogin(String token, String provider) {
    var body = json.encode({"provider": provider, "access_token": token});
    api.login(body).then((LoginResponse loginReponse) {
      _view.onLoginSuccess(loginReponse);
    }).catchError((Exception error) => _view.onLoginError(error.toString()));
  }
}
