import 'package:liulo/model/question.dart';

class Topic {
  String id;
  String title;
  String body;
  List<Question> listQuestion;

  Topic(this.id, this.title, this.body, this.listQuestion);
}
