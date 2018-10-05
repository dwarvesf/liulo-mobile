import 'package:liulo/model/event.dart';

class ListEventResponse {
  List<Event> data;

  ListEventResponse({this.data});

  ListEventResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Event>();
      json['data'].forEach((v) {
        data.add(new Event.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
