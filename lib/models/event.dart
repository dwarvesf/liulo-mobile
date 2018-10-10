import 'package:liulo/models/enum.dart';

class Event {
  int id;
  String code;
  String name;
  String description;
  DateTime startedAt;
  DateTime endedAt;
  EventStatus status;
  int ownerId;
}

class EventStatus extends Enum<int> {
  const EventStatus(int val) : super(val);

  static const EventStatus ACTIVE = const EventStatus(1);

  static const EventStatus BLOCKED = const EventStatus(2);

  static const EventStatus DELETED = const EventStatus(3);
}
