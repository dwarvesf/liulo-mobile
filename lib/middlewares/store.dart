import 'package:liulo/actions/index.dart';
import 'package:liulo/data/local/question_local_ds.dart';
import 'package:liulo/data/question_data_repository.dart';
import 'package:liulo/data/remote/question_remote_ds.dart';
import 'package:liulo/reducers/index.dart';
import 'package:liulo/repositories/question_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreMiddleware([
  QuestionRepository questionRepository = const QuestionDataRepository(
    localDS: const QuestionLocalDataSource(
      '__redux_app__',
      getApplicationDocumentsDirectory,
    ),
    remoteDS: const QuestionRemoteDataSource(delay: Duration(milliseconds: 2000)),
  ),
]) {
  final saveQuestions = _createSaveQuestions(questionRepository);
  final loadQuestions = _createLoadQuestions(questionRepository);
  final loadQuestionsByTopic = _createLoadQuestionsByTopic(questionRepository);

  return [
    TypedMiddleware<AppState, InitQuestionsAction>(loadQuestions),
    TypedMiddleware<AppState, LoadQuestionsByTopicAction>(loadQuestionsByTopic),
    TypedMiddleware<AppState, AddQuestionAction>(saveQuestions),
    TypedMiddleware<AppState, AddQuestionsAction>(saveQuestions),
    TypedMiddleware<AppState, UpdateQuestionAction>(saveQuestions),
    TypedMiddleware<AppState, DeleteQuestionAction>(saveQuestions),
    TypedMiddleware<AppState, ReplaceQuestionsAction>(saveQuestions),
    TypedMiddleware<AppState, UpVoteQuestionAction>(saveQuestions),
  ];
}

Middleware<AppState> _createLoadQuestions(QuestionRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.load().then((questions) {
      store.dispatch(ReplaceQuestionsAction(questions));
    });
    next(action);
  };
}

Middleware<AppState> _createLoadQuestionsByTopic(QuestionRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.getByTopic(0).then((questions) {
      store.dispatch(ReplaceQuestionsAction(questions));
    });
    next(action);
  };
}

Middleware<AppState> _createSaveQuestions(QuestionRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    repository.save(store.state.questions);
  };
}
