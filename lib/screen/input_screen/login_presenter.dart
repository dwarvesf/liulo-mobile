import 'package:liulo/data/rest_ds.dart';
import 'package:liulo/model/response/login_response.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(LoginResponse loginReponse);

  void onLoginError(String errorTxt);
}

class LoginPresenter {
  LoginScreenContract _view;
  RestDatasource api = new RestDatasource();

  LoginPresenter(this._view);

  doLogin(String token, String provider) {
    api.login(token, provider).then((LoginResponse loginReponse) {
      _view.onLoginSuccess(loginReponse);
    }).catchError((Exception error) => _view.onLoginError(error.toString()));
  }
}
