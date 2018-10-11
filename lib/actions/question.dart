import 'dart:async';

import 'package:liulo/application.dart';
import 'package:liulo/models/question.dart';
import 'package:liulo/reducers/index.dart';
import 'package:redux/redux.dart';

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

class LoadQuestionsByTopicAction {
  final int topicId;

  LoadQuestionsByTopicAction(this.topicId);

  call() => (Store<AppState> store) async {
        try {
          var questions = await Application.questionRepository.getByTopic(topicId);
          store.dispatch(ReplaceQuestionsAction(questions));
          return questions;
        } catch (e) {
          print("LoadQuestionsByTopicAction: error: ${e.toString()}");
          return [];
        }
      };
}

class UpVoteQuestionAction {
  final int questionId;

  UpVoteQuestionAction(this.questionId);

  call() => (Store<AppState> store) async {
        Question question = store.state.questions.firstWhere((question) => question.id == questionId, orElse: null);
        if (question == null) return Future.error(NullThrownError());
        try {
          question.voteCount += 1;
          question.isVoted = true;
          store.dispatch(UpdateQuestionAction(question));
          await Application.questionRepository.upVote(questionId);
          return question;
        } catch (e) {
          print("UpVoteQuestionAction: error: ${e.toString()}");
          return Future.error(e);
        }
      };
}

class UnVoteQuestionAction {
  final int questionId;

  UnVoteQuestionAction(this.questionId);

  call() => (Store<AppState> store) async {
    Question question = store.state.questions.firstWhere((question) => question.id == questionId, orElse: null);
    if (question == null) return Future.error(NullThrownError());
    try {
      question.voteCount -= 1;
      question.isVoted = false;
      store.dispatch(UpdateQuestionAction(question));
      await Application.questionRepository.upVote(questionId);
      return question;
    } catch (e) {
      print("UnVoteQuestionAction: error: ${e.toString()}");
      return Future.error(e);
    }
  };
}

class CreateQuestionAction {
  final Question question;

  CreateQuestionAction(this.question);

  call() => (Store<AppState> store) async {
        if (question == null) return Future.error(NullThrownError());
        try {
          var createdQuestion = await Application.questionRepository.create(question);
          store.dispatch(AddQuestionAction(createdQuestion));
          return createdQuestion;
        } catch (e) {
          print("CreateQuestionAction: error: ${e.toString()}");
          return Future.error(e);
        }
      };
}
