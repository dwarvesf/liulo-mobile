import 'package:liulo/model/event.dart';

class CreateEventResponse {
  Event data;

  CreateEventResponse({this.data});

  CreateEventResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Event.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
