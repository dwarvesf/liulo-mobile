import 'package:liulo/actions/app_loading.dart';
import 'package:redux/redux.dart';

final appLoadingReducer = combineReducers<bool>([
  TypedReducer<bool, SetAppLoadedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}
