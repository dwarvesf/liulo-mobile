import 'dart:ui';

import 'package:flutter/material.dart';

class ViewUtil {
  static String getValueCheck(String status) {
    if (status == "pending")
      return "anwsered";
    else if (status == "anwsered") return "pending";
    return "pending";
  }

  static Color getColorCheckButton(String status) {
    if (status == "pending")
      return Colors.grey;
    else if (status == "anwsered") return Colors.blue;
    return Colors.grey;
  }

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static void showDialogConnection(BuildContext mContext) {
    // flutter defined function
    showDialog(
      context: mContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Network"),
          content: new Text(
              "Cannot connect to server. Please check your connection strength and try again"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
