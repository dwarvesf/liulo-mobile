import 'package:liulo/actions/index.dart';
import 'package:liulo/reducers/index.dart';
import 'package:liulo/repositories/index.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> questionMiddleware(QuestionRepository questionRepository) {
  final save = _save(questionRepository);
  final load = _load(questionRepository);

  return [
    TypedMiddleware<AppState, LoadPersistentDataAction>(load),
    TypedMiddleware<AppState, AddQuestionAction>(save),
    TypedMiddleware<AppState, AddQuestionsAction>(save),
    TypedMiddleware<AppState, UpdateQuestionAction>(save),
    TypedMiddleware<AppState, DeleteQuestionAction>(save),
    TypedMiddleware<AppState, ReplaceQuestionsAction>(save),
  ];
}

Middleware<AppState> _load(QuestionRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.load().then((questions) {
      store.dispatch(ReplaceQuestionsAction(questions));
    });
    next(action);
  };
}

Middleware<AppState> _save(QuestionRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    repository.save(store.state.questions);
  };
}
