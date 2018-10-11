import 'dart:async';

import 'package:liulo/models/question.dart';

class QuestionRemoteDataSource {
  final Duration delay;

  const QuestionRemoteDataSource({this.delay = const Duration(milliseconds: 200)});

  /// Mock that fetches data from an API after a short delay
  Future<List<Question>> getByTopic(int topicId) async {
    return Future.delayed(
        delay,
        () => [
              Question(
                id: 1,
                description: "What time is it?",
                voteCount: 3,
                status: QuestionStatus.ACTIVE,
                topicId: 1,
                ownerId: 0,
                isAnonymous: true,
              ),
              Question(
                id: 2,
                description: "How much does it cost?",
                voteCount: 4,
                status: QuestionStatus.ACTIVE,
                topicId: 1,
                ownerId: 0,
                isAnonymous: true,
              ),
              Question(
                id: 3,
                description: "Who will join?",
                voteCount: 5,
                status: QuestionStatus.ACTIVE,
                topicId: 1,
                ownerId: 0,
                isAnonymous: true,
              ),
            ]);
  }

  /// Mock that will "Always Succeed"
  Future<Question> create(Question question) async {
    return Future.delayed(delay, () {
      question.id = DateTime.now().millisecondsSinceEpoch;
      question.status = QuestionStatus.ACTIVE;
      return question;
    });
  }

  /// Mock that will "Always Succeed"
  Future<Question> update(Question question) async {
    return Future.delayed(delay, () {
      return question;
    });
  }

  /// Mock that will "Always Succeed"
  Future upVote(int questionId) async {
    return Future.delayed(delay, () {
      return null;
    });
  }
}
