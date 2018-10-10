export 'app_loading.dart';
export 'loading.dart';
export 'question.dart';
export 'user.dart';

import 'dart:async';

import 'package:liulo/actions/app_loading.dart';
import 'package:liulo/reducers/index.dart';
import 'package:redux/redux.dart';

class LoadPersistentDataAction {}

class RehydrateAction {
  call() => (Store<AppState> store) async {
    store.dispatch(LoadPersistentDataAction());
    await Future.delayed(Duration(seconds: 1), () => store.dispatch(SetAppLoadedAction()));
  };
}
