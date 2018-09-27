import 'package:liulo/model/event.dart';
import 'package:liulo/utils/data_util.dart';

abstract class ListEventScreenContract {
  void onGetDataSuccess(List<Event> items);
}

class ListEventPresenter {
  ListEventScreenContract _view;

  ListEventPresenter(this._view);

  void fakeData() {
    _view.onGetDataSuccess(DataUtil.getFakeListEvent());
  }
}
