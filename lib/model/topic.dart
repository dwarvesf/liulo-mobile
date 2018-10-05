class Topic {
  String status;
  Null startedAt;
  String speakerNames;
  String name;
  int id;
  Null endedAt;
  String description;

  Topic(this.status,
      this.startedAt,
      this.speakerNames,
      this.name,
      this.id,
      this.endedAt,
      this.description);

  Topic.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    startedAt = json['started_at'];
    speakerNames = json['speaker_names'];
    name = json['name'];
    id = json['id'];
    endedAt = json['ended_at'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['started_at'] = this.startedAt;
    data['speaker_names'] = this.speakerNames;
    data['name'] = this.name;
    data['id'] = this.id;
    data['ended_at'] = this.endedAt;
    data['description'] = this.description;
    return data;
  }
}