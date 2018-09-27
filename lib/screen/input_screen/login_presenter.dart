import 'package:liulo/data/rest_ds.dart';
import 'package:liulo/model/user.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(User user);

  void onLoginError(String errorTxt);
}

class LoginPresenter {
  LoginScreenContract _view;
  RestDatasource api = new RestDatasource();

  LoginPresenter(this._view);

  doLogin(String token, String provider) {
    api.login(token, provider).then((User user) {
      _view.onLoginSuccess(user);
    }).catchError((Exception error) => _view.onLoginError(error.toString()));
  }
}
