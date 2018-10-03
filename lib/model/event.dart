import 'package:liulo/model/topic.dart';

class Event {
  String id;
  String title;
  String body;
  List<Topic> listTopic;

  Event(this.id, this.title, this.body, this.listTopic);
}
