class CreateTopicRequest {
  int id;
  TopicRequest topicRequest;

  CreateTopicRequest(this.id, this.topicRequest);

  CreateTopicRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topicRequest =
        json['topic'] != null ? new TopicRequest.fromJson(json['topic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.topicRequest != null) {
      data['topic'] = this.topicRequest.toJson();
    }
    return data;
  }
}

class TopicRequest {
  String name;
  String description;
  String speakerNames;

  TopicRequest(this.name, this.description, this.speakerNames);

  TopicRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    speakerNames = json['speaker_names'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['speaker_names'] = this.speakerNames;
    return data;
  }
}
