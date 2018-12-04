class Question {
  int voteCount;
  String status;
  int ownerId;
  bool isVoted;
  bool isAnonymous;
  int id;
  String description;

  Question({this.voteCount,
    this.status,
    this.ownerId,
    this.isVoted,
    this.isAnonymous,
    this.id,
    this.description});

  Question.fromJson(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    status = json['status'];
    ownerId = json['owner_id'];
    isVoted = json['is_voted'];
    isAnonymous = json['is_anonymous'];
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote_count'] = this.voteCount;
    data['status'] = this.status;
    data['owner_id'] = this.ownerId;
    data['is_voted'] = this.isVoted;
    data['is_anonymous'] = this.isAnonymous;
    data['id'] = this.id;
    data['description'] = this.description;
    return data;
  }
}