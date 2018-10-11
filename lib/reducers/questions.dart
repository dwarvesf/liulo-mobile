import 'package:redux/redux.dart';
import 'package:liulo/actions/question.dart';
import 'package:liulo/models/question.dart';

final questionsReducer = combineReducers<List<Question>>([
  TypedReducer<List<Question>, AddQuestionAction>(_add),
  TypedReducer<List<Question>, AddQuestionsAction>(_addMany),
  TypedReducer<List<Question>, UpdateQuestionAction>(_update),
  TypedReducer<List<Question>, DeleteQuestionAction>(_delete),
  TypedReducer<List<Question>, ReplaceQuestionsAction>(_replaceAll),
]);

List<Question> _add(List<Question> state, AddQuestionAction action) {
  return List.from(state)..add(action.question)..sort();
}

List<Question> _addMany(List<Question> state, AddQuestionsAction action) {
  var newQuestions = action.questions.where((question) => !state.contains(question)).toList();
  return state.map((question) {
    var updatedQuestion = action.questions.firstWhere((newQuestion) => question == newQuestion, orElse: null);
    return updatedQuestion != null ? updatedQuestion : question;
  }).toList()
    ..addAll(newQuestions)..sort();
}

List<Question> _update(List<Question> state, UpdateQuestionAction action) {
  return state.map((question) => question.id == action.question.id ? action.question : question).toList();
}

List<Question> _delete(List<Question> state, DeleteQuestionAction action) {
  return state.where((question) => question.id != action.id).toList();
}

List<Question> _replaceAll(List<Question> state, ReplaceQuestionsAction action) {
  return List.from(action.questions)..sort();
}
