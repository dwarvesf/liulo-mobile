class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  bool isChecked = false;

  Post(this.userId, this.id, this.title, this.body);
}
