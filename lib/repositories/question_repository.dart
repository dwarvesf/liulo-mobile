import 'dart:async';

import 'package:liulo/models/question.dart';

abstract class QuestionRepository {
  Future<List<Question>> load();

  Future save(List<Question> data);

  Future<List<Question>> getByTopic(int topicId);

  Future<Question> create(Question question);

  Future<Question> update(Question question);

  Future upVote(int questionId);
}
