import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:liulo/application.dart';
import 'package:liulo/models/question.dart';

class QuestionListItemNew extends StatefulWidget {
  final Function onCreatePressed;

  QuestionListItemNew({this.onCreatePressed});

  @override
  _State createState() => _State();
}

class _State extends State<QuestionListItemNew> {
  // Create a text controller. We will use it to retrieve the current value of the TextField!
  final _questionTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _questionTextController.dispose();
    super.dispose();
  }

  void _onCreatePressed() {
    if (_questionTextController.text.isEmpty) return;
    widget.onCreatePressed(Question(description: _questionTextController.text));
    Application.socketRepository.send(_questionTextController.text);
    Application.locationRepository.getCurrentPosition(LocationAccuracy.high).then((position) {
      print(position);
    });
    _questionTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                new Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(border: InputBorder.none, hintText: 'Ask a question...'),
                        style: Theme.of(context).textTheme.title,
                        maxLines: 3,
                        controller: _questionTextController,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _onCreatePressed,
                  tooltip: 'Send Question',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
