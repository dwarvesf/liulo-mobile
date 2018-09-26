import 'package:flutter/material.dart';
import 'package:liulo/screen/user/UserHomeScreen.dart';

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

class _InputScreenState extends State<InputScreen> {
  String results = "";

  final TextEditingController controller = new TextEditingController();

  void login() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UserHomeScreen(title: 'User Page')),
    );
  }

  void join() {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
    );
  }
}
