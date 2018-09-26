import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  UserHomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserHomeScreenState createState() => new _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
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
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'User name: Thanh Nguyen',
                softWrap: true,
              ),
            ),
            new Container(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Email: thanhnd@gmail.com',
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
                onPressed: subtractNumbers,
                textColor: Colors.white,
                color: Colors.green,
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "Manage Your Event",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
