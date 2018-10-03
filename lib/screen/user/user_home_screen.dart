import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liulo/model/user.dart';
import 'package:liulo/screen/list_event/list_event_screen.dart';
import 'package:liulo/utils/signin_util.dart';

class UserHomeScreen extends StatefulWidget {
  UserHomeScreen({Key key, this.title, this.user}) : super(key: key);

  final String title;
  final User user;
  @override
  _UserHomeScreenState createState() => new _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

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
            onPressed: () => exit(0),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  String results = "";


  final TextEditingController controller = new TextEditingController();

  void subtractNumbers() {}

  void replaceToManageEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListEventScreen(title: 'Manage Event')),
    );
  }

  Future<Null> _handleSignOut() async {
    SignInUtil.googleSignIn.disconnect();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
            title: new Text(widget.title),
            automaticallyImplyLeading: false
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'User name:  ${widget.user.fullName}',
                  softWrap: true,
                ),
              ),
              new Container(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Email:  ${widget.user.email}',
                  softWrap: true,
                ),
              ),
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
                  onPressed: subtractNumbers,
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
                  onPressed: subtractNumbers,
                  textColor: Colors.white,
                  color: Colors.blue,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Create Event",
                  ),
                ),
              ),

              new ButtonTheme(
                minWidth: 150.0,
                height: 36.0,
                child: RaisedButton(
                  onPressed: replaceToManageEvent,
                  textColor: Colors.white,
                  color: Colors.green,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Manage Your Event",
                  ),
                ),
              ),

              new ButtonTheme(
                minWidth: 150.0,
                height: 36.0,
                child: RaisedButton(
                  onPressed: _handleSignOut,
                  textColor: Colors.white,
                  color: Colors.brown,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "LogOut",
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
