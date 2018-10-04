import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:liulo/actions/index.dart';
import 'package:liulo/reducers/index.dart';
import 'package:liulo/models/question.dart';
import 'package:liulo/views/question_list/question_list_item.dart';
import 'package:liulo/views/question_list/question_list_item_new.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<Question> items;
  final Function onUpVotePressed;
  final Function onUnVotePressed;
  final Function createQuestion;

  _ViewModel({
    this.items,
    this.onUpVotePressed,
    this.onUnVotePressed,
    this.createQuestion,
  });

  factory _ViewModel.create(Store<AppState> store) {
    List<Question> items = store.state.questions;

    return _ViewModel(
      items: items,
      onUpVotePressed: (int questionId) => store.dispatch(UpVoteQuestionAction(questionId)()),
      onUnVotePressed: (int questionId) => store.dispatch(UnVoteQuestionAction(questionId)()),
      createQuestion: (Question question) => store.dispatch(CreateQuestionAction(question)()),
    );
  }
}

class QuestionListScreen extends StatelessWidget {
  final int topicId;

  QuestionListScreen({this.topicId = 0});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => Scaffold(
              appBar: AppBar(
                title: const Text('Questions'),
              ),
              body: ListView.builder(
                itemCount: viewModel.items.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return QuestionListItemNew(
                      onCreatePressed: _createQuestion(viewModel),
                    );
                  }
                  return QuestionListItem(
                    item: viewModel.items[index - 1],
                    onUpVotePressed: () => viewModel.onUpVotePressed(viewModel.items[index - 1].id),
                    onUnVotePressed: () => viewModel.onUnVotePressed(viewModel.items[index - 1].id),
                  );
                },
              ),
            ),
      );

  void Function(Question) _createQuestion(_ViewModel viewModel) => (Question newQuestion) {
        viewModel.createQuestion(newQuestion);
      };
}
