/*
 * fluro
 * A Posse Production
 * http://goposse.com
 * Copyright (c) 2018 Posse Productions LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
import 'package:flutter/material.dart';

class DemoSimpleComponent extends StatelessWidget {
  DemoSimpleComponent(
      {String message = "Testing",
      Color color = const Color(0xFFFFFFFF),
      String result})
      : this.message = message,
        this.color = color,
        this.result = result;

  final String message;
  final Color color;
  final String result;

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: color,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Image(
            image: new AssetImage("assets/images/acc_boom.png"),
            color: Colors.lightBlue,
            width: 260.0,
          ),
          new Padding(
            padding: new EdgeInsets.only(left: 50.0, right: 50.0, top: 15.0),
            child: new Text(
              message,
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: Colors.green,
                height: 2.0,
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.only(top: 15.0),
            child: new ConstrainedBox(
              constraints: new BoxConstraints(minHeight: 42.0),
              child: new FlatButton(
                highlightColor:
                    Colors.blueAccent.withAlpha(17),
                splashColor:
                    Colors.blueAccent.withAlpha(34),
                onPressed: () {
                  if (result == null) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context, result);
                  }
                },
                child: new Text(
                  "OK",
                  style: new TextStyle(
                    fontSize: 18.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
