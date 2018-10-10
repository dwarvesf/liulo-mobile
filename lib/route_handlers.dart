import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:liulo/actions/index.dart';
import 'package:liulo/reducers/index.dart';
import 'package:liulo/screen/input_screen/input_screen.dart';
import 'package:liulo/views/app_loading/index.dart';
import 'views/question_list/index.dart';

var rootHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return StoreBuilder<AppState>(
    onInit: (store) => store.dispatch(RehydrateAction()()),
    builder: (context, store) {
      if (store.state.appLoading) return AppLoadingComponent();
      return InputScreen(title: "hello");
    },
  );
});

var questionHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  int topicId = int.tryParse(params["topicId"][0]) ?? 0;
  return StoreBuilder<AppState>(
    onInit: (store) => store.dispatch(LoadQuestionsByTopicAction(topicId)()),
    builder: (context, store) {
      return QuestionListScreen(topicId: topicId);
    },
  );
});
