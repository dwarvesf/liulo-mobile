import 'package:liulo/middlewares/question.dart';
import 'package:liulo/reducers/index.dart';
import 'package:liulo/repositories/question_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

List<Middleware<AppState>> createStoreMiddleware([
  QuestionRepository questionRepository,
]) {
  return List.from(questionMiddleware(questionRepository))..add(thunkMiddleware);
}
