import 'package:liulo/actions/index.dart';
import 'package:liulo/models/question.dart';
import 'package:liulo/reducers/index.dart';
import 'package:redux/redux.dart';

class QuestionListViewModel {
  final List<Question> items;
  final Function onUpVotePressed;

  QuestionListViewModel({this.items, this.onUpVotePressed});

  factory QuestionListViewModel.create(Store<AppState> store) {
    List<Question> items = store.state.questions;

    return QuestionListViewModel(items: items, onUpVotePressed: (int questionId) => store.dispatch(UpVoteQuestionAction(questionId)));
  }
}
