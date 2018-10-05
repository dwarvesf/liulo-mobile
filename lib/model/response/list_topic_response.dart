import 'package:liulo/model/topic.dart';

class ListTopicResponse {
  List<Topic> data;

  ListTopicResponse({this.data});

  ListTopicResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Topic>();
      json['data'].forEach((v) {
        data.add(new Topic.fromJson(v));
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
