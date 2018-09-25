import 'package:liulo/models/question.dart';

class InitQuestionsAction {}

class LoadQuestionsByTopicAction {
  final int topicId;

  LoadQuestionsByTopicAction(this.topicId);
}

class AddQuestionAction {
  final Question question;

  AddQuestionAction(this.question);
}

class AddQuestionsAction {
  final List<Question> questions;

  AddQuestionsAction(this.questions);
}

class UpdateQuestionAction {
  final Question question;

  UpdateQuestionAction(this.question);
}

class DeleteQuestionAction {
  final int id;

  DeleteQuestionAction(this.id);
}

class ReplaceQuestionsAction {
  final List<Question> questions;

  ReplaceQuestionsAction(this.questions);
}

class UpVoteQuestionAction {
  final int id;

  UpVoteQuestionAction(this.id);
}
