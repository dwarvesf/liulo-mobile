import 'package:liulo/models/enum.dart';

class QuestionStatus extends Enum<int> {
  const QuestionStatus(int val) : super(val);

  static const QuestionStatus ACTIVE = const QuestionStatus(1);

  static const QuestionStatus BLOCKED = const QuestionStatus(2);

  static const QuestionStatus DELETED = const QuestionStatus(3);
}

class Question implements Comparable<Question> {
  int id;
  String description;
  int voteCount;
  QuestionStatus status;
  int topicId;
  int ownerId;
  bool isAnonymous;
  bool isVoted;

  Question({
    this.id = 0,
    this.description = "",
    this.voteCount = 0,
    this.status = QuestionStatus.ACTIVE,
    this.topicId = 0,
    this.ownerId = 0,
    this.isAnonymous = true,
    this.isVoted = false,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      description: json['description'],
      voteCount: json['vote_count'],
      status: QuestionStatus(json['status']),
      topicId: json['topic_id'],
      ownerId: json['owner_id'],
      isAnonymous: json['is_anonymous'],
      isVoted: json['is_voted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "vote_count": voteCount,
      "status": status.value,
      "topic_id": topicId,
      "owner_id": ownerId,
      "is_anonymous": isAnonymous,
      "is_voted": isVoted,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question && runtimeType == other.runtimeType && id == other.id && topicId == other.topicId;

  @override
  int get hashCode => id.hashCode ^ topicId.hashCode;

  @override
  String toString() {
    return 'Question{description: $description}';
  }

  @override
  int compareTo(Question other) {
    return -this.id.compareTo(other.id);
  }

}
