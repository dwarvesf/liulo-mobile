import 'package:liulo/models/enum.dart';

class Topic {
  int id;
  String name;
  String description;
  DateTime startedAt;
  DateTime endedAt;
  String speakers;
  TopicStatus status;
  int eventId;
  int ownerId;
}

class TopicStatus extends Enum<int> {
  const TopicStatus(int val) : super(val);

  static const TopicStatus ACTIVE = const TopicStatus(1);

  static const TopicStatus BLOCKED = const TopicStatus(2);

  static const TopicStatus DELETED = const TopicStatus(3);
}
