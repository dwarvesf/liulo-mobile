import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:liulo/application.dart';
import 'package:liulo/model/response/login_response.dart';
import 'package:liulo/model/user.dart';
import 'package:liulo/routes.dart';
import 'package:liulo/screen/input_screen/input_presenter.dart';
import 'package:liulo/screen/user/user_home_screen.dart';
import 'package:liulo/utils/signin_util.dart';
import 'package:liulo/utils/token_util.dart';
import 'package:liulo/utils/view_util.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InputScreen(title: 'Líu Lo Demo');
  }
}

class InputScreen extends StatefulWidget {
  InputScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InputScreenState createState() => new _InputScreenState();
}

class _InputScreenState extends State<InputScreen>
    implements InputScreenContract {
  GoogleSignInAccount _currentUser;
  User user;
  bool visibilityView = false;
  bool isFirstTimeOpen = true;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  InputPresenter _presenter;

  _InputScreenState() {
    _presenter = new InputPresenter(this);
  }

  void _changed(bool visibility) {
    setState(() {
      visibilityView = visibility;
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    if (_currentUser != null) {
      visibilityView = false;
    } else {
      visibilityView = true;
    }

    SignInUtil.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      checkCurrentUser();
    });
    SignInUtil.googleSignIn.signInSilently();
  }

  void checkCurrentUser() {
    if (_currentUser != null) {
      print(_currentUser);
      if (isFirstTimeOpen) {
        _changed(false);
        isFirstTimeOpen = false;
      }
      _getToken();

    } else {
      _changed(true);
    }
  }

  void login() {
    isFirstTimeOpen = false;
    _handleSignOutAndLogin();
  }

  Future<Null> _handleSignIn() async {
    try {
      await SignInUtil.googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<Null> _handleSignOutAndLogin() async {
    SignInUtil.googleSignIn.disconnect();
    _handleSignIn();
  }

  Future<Null> _getToken() async {
    final GoogleSignInAuthentication auth = await _currentUser.authentication;
    if (auth != null) {
      var connectivityResult = await (new Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        ViewUtil.showDialogConnection(context);
      } else {
        setState(() => _isLoading = true);
        _presenter.doLogin(auth.accessToken, "google");
      }
    } else {
      _changed(true);
    }
  }

  String results = "";

  final TextEditingController controller = new TextEditingController();

  void replaceToUserHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              UserHomeScreen(
                  title: 'User Page',
                  //user: new User("", 1, "", _currentUser.displayName, _currentUser.email))),
                  user: user)),
    );
  }

  void join() {
    Application.router.navigateTo(context, "${Routes.questions}/1");
  }

  void goToMapScreen() {
    Application.router.navigateTo(context, Routes.map);
  }

  void goToTestScreen() {
    Application.router.navigateTo(context, Routes.test);
  }

  void goToVideoPlayerScreen() {
    Application.router.navigateTo(context, Routes.videoPlayer);
  }

  @override
  Widget build(BuildContext context) {
    if (visibilityView) {
      return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          key: scaffoldKey,
          appBar: new AppBar(
            title: new Text(widget.title),
          ),
          body:
          new Stack(
            children: _buildForm(context),
          ),

        ),
      );
    } else {
      return new Container(
        decoration: new BoxDecoration(color: Colors.white),
      );
    }
  }

  List<Widget> _buildForm(BuildContext context) {
    var center = new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 10.0),
              child: new TextField(
                decoration:
                new InputDecoration(hintText: "Enter text here..."),
                onSubmitted: (String str) {
                  setState(() {
                    results = results + "\n" + str;
                    controller.text = "";
                  });
                },
                controller: controller,
              )),
          new ButtonTheme(
            minWidth: 150.0,
            height: 36.0,
            child: RaisedButton(
              onPressed: join,
              textColor: Colors.white,
              color: Colors.red,
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Join Event",
              ),
            ),
          ),
          new ButtonTheme(
            minWidth: 150.0,
            height: 36.0,
            child: RaisedButton(
              onPressed: login,
              textColor: Colors.white,
              color: Colors.blue,
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Login",
              ),
            ),
          ),

          new ButtonTheme(
            minWidth: 150.0,
            height: 36.0,
            child: RaisedButton(
              onPressed: goToMapScreen,
              textColor: Colors.white,
              color: Colors.red,
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Map View",
              ),
            ),
          ),

          new ButtonTheme(
            minWidth: 150.0,
            height: 36.0,
            child: RaisedButton(
              onPressed: goToVideoPlayerScreen,
              textColor: Colors.cyan,
              color: Colors.red,
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Video Player",
              ),
            ),
          ),

           new ButtonTheme(
            minWidth: 150.0,
            height: 36.0,
            child: RaisedButton(
              onPressed: goToTestScreen,
              textColor: Colors.white,
              color: Colors.red,
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Test View",
              ),
            ),
          ),

        ],
      ),

    );

    var l = new List<Widget>();
    l.add(center);

    if (_isLoading) {
      var modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          new Center(
            child: new CircularProgressIndicator(),
          ),
        ],
      );
      l.add(modal);
    }

    return l;
  }


  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    print(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(LoginResponse loginReponse) async {
    print(loginReponse.data.jwt);

    setState(() => _isLoading = false);
    this.user = loginReponse.data.user;
    await TokenUtil.setUserLocal(loginReponse.data.jwt);
    replaceToUserHome();
    new Future.delayed(const Duration(seconds: 3), () {
      _changed(true);
    });
  }
}
