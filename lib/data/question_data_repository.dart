import 'dart:async';

import 'package:liulo/data/local/question_local_ds.dart';
import 'package:liulo/data/remote/question_remote_ds.dart';
import 'package:liulo/models/question.dart';
import 'package:liulo/repositories/question_repository.dart';

class QuestionDataRepository implements QuestionRepository {
  final QuestionLocalDataSource _localDS;
  final QuestionRemoteDataSource _remoteDS;

  const QuestionDataRepository({
    QuestionLocalDataSource localDS,
    QuestionRemoteDataSource remoteDS,
  })  : _localDS = localDS,
        _remoteDS = remoteDS;

  @override
  Future<List<Question>> load() async {
    try {
      return await _localDS.load();
    } catch (e) {
      return const [];
    }
  }

  @override
  Future save(List<Question> data) {
    return _localDS.save(data);
  }

  @override
  Future<List<Question>> getByTopic(int topicId) {
    return _remoteDS.getByTopic(topicId);
  }

  @override
  Future<Question> create(Question question) {
    return _remoteDS.create(question);
  }

  @override
  Future<Question> update(Question question) {
    return _remoteDS.update(question);
  }
}
