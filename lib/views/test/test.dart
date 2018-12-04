import 'dart:async';

import 'package:flutter/material.dart';

// class TestScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Hello"),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         color: Colors.amber,
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   child: Text(
//                     "Lorem",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.red, fontSize: 14),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     "Ipsum",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.blue, fontSize: 14),
//                   ),
//                 ),
//               ],
//             ),
//             Icon(Icons.lightbulb_outline, size: 48.0, color: Colors.redAccent),
//             Text("Hello World"),
//           ],
//         ),
//       ),
//     );
//   }
// }

class TestScreen extends StatefulWidget {
  final String title;

  TestScreen({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool showtext = true;
  bool toggleState = true;
  Timer t2;

  void toggleBlinkState() {
    setState(() {
      toggleState = !toggleState;
    });
    var twenty = const Duration(milliseconds: 1000);
    if (toggleState == false) {
      t2 = Timer.periodic(twenty, (Timer t) {
        toggleShowText();
      });
    } else {
      t2.cancel();
    }
  }

  void toggleShowText() {
    setState(() {
      showtext = !showtext;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            (showtext
                ? (Text('This execution will be done before you can blink.'))
                : (Container())),
            Padding(
                padding: EdgeInsets.only(top: 70.0),
                child: RaisedButton(
                    onPressed: toggleBlinkState,
                    child: (toggleState
                        ? (Text('Blink'))
                        : (Text('Stop Blinking')))))
          ],
        ),
      ),
    );
  }
}
