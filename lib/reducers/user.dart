import 'package:liulo/actions/user.dart';
import 'package:liulo/models/user.dart';
import 'package:redux/redux.dart';

final userReducer = combineReducers<User>([
  TypedReducer<User, SetUserAction>(_set),
  TypedReducer<User, ClearUserAction>(_clear),
]);

User _set(User state, SetUserAction action) {
  return action.user;
}

User _clear(User state, ClearUserAction action) {
  return null;
}
