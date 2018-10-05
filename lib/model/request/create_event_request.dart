class CreateEventRequest {
  EventItem event;

  CreateEventRequest(this.event);

  CreateEventRequest.fromJson(Map<String, dynamic> json) {
    event =
        json['event'] != null ? new EventItem.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.event != null) {
      data['event'] = this.event.toJson();
    }
    return data;
  }
}

class EventItem {
  String name;
  String description;

  EventItem(this.name, this.description);

  EventItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
