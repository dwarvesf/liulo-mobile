import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Líu Lo',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new MyHomePage(title: 'Líu Lo Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String results = "";

  final TextEditingController controller = new TextEditingController();

  void addNumbers() {}

  void subtractNumbers() {}

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
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
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
            new RaisedButton(
              onPressed: subtractNumbers,
              textColor: Colors.white,
              color: Colors.red,
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Join",
              ),
            ),
            new RaisedButton(
              onPressed: subtractNumbers,
              textColor: Colors.white,
              color: Colors.blue,
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Login",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
