import 'package:liulo/models/loading.dart';
import 'package:liulo/models/question.dart';
import 'package:liulo/models/user.dart';
import 'package:liulo/reducers/app_loading.dart';
import 'package:liulo/reducers/user.dart';
import 'package:liulo/reducers/questions.dart';
import 'package:liulo/reducers/loadings.dart';

class AppState {
  final bool appLoading;
  final User user;
  final List<Loading> loadings;
  final List<Question> questions;

  AppState({
    this.appLoading,
    this.user,
    this.loadings,
    this.questions,
  });

  factory AppState.initialState() => AppState(
        appLoading: true,
        user: null,
        loadings: [],
        questions: [],
      );

  AppState copyWith({
    bool appLoading,
    User user,
    List<Loading> loadings,
    List<Question> questions,
  }) {
    return AppState(
      appLoading: appLoading ?? this.appLoading,
      user: user ?? this.user,
      loadings: loadings ?? this.loadings,
      questions: questions ?? this.questions,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          appLoading == other.appLoading &&
          user == other.user &&
          loadings == other.loadings &&
          questions == other.questions;

  @override
  int get hashCode => appLoading.hashCode ^ user.hashCode ^ loadings.hashCode ^ questions.hashCode;
}

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  return AppState(
    appLoading: appLoadingReducer(state.appLoading, action),
    user: userReducer(state.user, action),
    loadings: loadingsReducer(state.loadings, action),
    questions: questionsReducer(state.questions, action),
  );
}
