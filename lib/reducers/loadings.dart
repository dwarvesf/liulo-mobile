import 'package:redux/redux.dart';
import 'package:liulo/models/loading.dart';
import 'package:liulo/actions/loading.dart';

final loadingsReducer = combineReducers<List<Loading>>([
  TypedReducer<List<Loading>, AddLoadingAction>(_add),
  TypedReducer<List<Loading>, UpdateLoadingAction>(_update),
  TypedReducer<List<Loading>, DeleteLoadingAction>(_delete),
]);

List<Loading> _add(List<Loading> state, AddLoadingAction action) {
  return List.from(state)..add(action.loading);
}

List<Loading> _update(List<Loading> state, UpdateLoadingAction action) {
  return state.map((loading) => loading.id == action.loading.id ? action.loading : loading).toList();
}

List<Loading> _delete(List<Loading> state, DeleteLoadingAction action) {
  return state.where((loading) => loading.id != action.id).toList();
}

