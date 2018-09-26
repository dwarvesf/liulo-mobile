import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:http/http.dart" as http;
import 'package:liulo/screen/user/user_home_screen.dart';


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

class _InputScreenState extends State<InputScreen> with WidgetsBindingObserver {
  GoogleSignInAccount _currentUser;
  String _contactText;
  bool visibilityView = false;
  bool isFirstTimeOpen = true;

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

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        if (isFirstTimeOpen) {
          _changed(false);
          isFirstTimeOpen = false;
        }

        _handleGetContact();
      } else {
        _changed(true);
      }
    });
    _googleSignIn.signInSilently();
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  void login() {
    isFirstTimeOpen = false;
    _handleSignOutAndLogin();
  }

  Future<Null> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<Null> _handleSignOutAndLogin() async {
    _googleSignIn.disconnect();
    _handleSignIn();
  }

  Future<Null> _handleGetContact() async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
        replaceToUserHome();
        new Future.delayed(const Duration(seconds: 3), () {
          _changed(true);
        });
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  String results = "";

  final TextEditingController controller = new TextEditingController();

  void replaceToUserHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UserHomeScreen(title: 'User Page')),
    );
  }

  void join() {}

  @override
  Widget build(BuildContext context) {
    if (visibilityView) {
      return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
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
}
