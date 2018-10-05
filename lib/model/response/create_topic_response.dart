import 'package:liulo/model/topic.dart';

class CreateTopicResponse {
  Topic data;

  CreateTopicResponse({this.data});

  CreateTopicResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Topic.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
