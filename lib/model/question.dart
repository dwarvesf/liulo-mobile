class Question {
  final int userId;
  final int id;
  final String title;
  final String body;
  bool isChecked = false;

  Question(this.userId, this.id, this.title, this.body);
}
