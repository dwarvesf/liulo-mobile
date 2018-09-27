import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:liulo/data/auth.dart';
import 'package:liulo/data/database_helper.dart';
import 'package:liulo/model/user.dart';
import 'package:liulo/screen/input_screen/login_presenter.dart';
import 'package:liulo/screen/user/user_home_screen.dart';
import 'package:liulo/utils/signin_util.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Líu Lo',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new InputScreen(title: 'Líu Lo Demo'),
    );
  }
}

class InputScreen extends StatefulWidget {
  InputScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InputScreenState createState() => new _InputScreenState();
}

class _InputScreenState extends State<InputScreen>
    implements LoginScreenContract, AuthStateListener {
  GoogleSignInAccount _currentUser;
  bool visibilityView = false;
  bool isFirstTimeOpen = true;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  LoginPresenter _presenter;

  _InputScreenState() {
    _presenter = new LoginPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
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
    SignInUtil.googleSignIn.onCurrentUserChanged.listen((
        GoogleSignInAccount account) {
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
      print(auth);

      replaceToUserHome();
      new Future.delayed(const Duration(seconds: 3), () {
        _changed(true);
      });
      //_presenter.doLogin(auth.idToken, "google");

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
              UserHomeScreen(title: 'User Page',
                  user: new User(
                      _currentUser.displayName, _currentUser.email, ""))),
    );
  }

  void join() {}

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
          body: new Center(
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
              ],
            ),
          ),
        ),
      );
    } else {
      return new Container(
        decoration: new BoxDecoration(color: Colors.white),
      );
    }
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
  void onLoginSuccess(User user) async {
    print(user);
    _showSnackBar(user.toString());
    setState(() => _isLoading = false);
    var db = new DatabaseHelper();
    await db.saveUser(user);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }

  @override
  void onAuthStateChanged(AuthState state) {
    if (state == AuthState.LOGGED_IN) replaceToUserHome();
  }
}
