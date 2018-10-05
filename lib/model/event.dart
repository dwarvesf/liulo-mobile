class Event {
  String status;
  String startedAt;
  String name;
  int id;
  String endedAt;
  String description;
  String code;

  Event(this.status,
      this.startedAt,
      this.name,
      this.id,
      this.endedAt,
      this.description,
      this.code);

  Event.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    startedAt = json['started_at'];
    name = json['name'];
    id = json['id'];
    endedAt = json['ended_at'];
    description = json['description'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['started_at'] = this.startedAt;
    data['name'] = this.name;
    data['id'] = this.id;
    data['ended_at'] = this.endedAt;
    data['description'] = this.description;
    data['code'] = this.code;
    return data;
  }
}