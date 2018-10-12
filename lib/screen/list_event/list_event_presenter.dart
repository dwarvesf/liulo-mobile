import 'package:liulo/data/rest_ds.dart';
import 'package:liulo/model/event.dart';
import 'package:liulo/model/response/list_event_response.dart';


abstract class ListEventScreenContract {
  void onGetDataSuccess(List<Event> items);

  void onGetDataFailed(String error);
}

class ListEventPresenter {
  ListEventScreenContract _view;
  RestDatasource api = new RestDatasource();

  ListEventPresenter(this._view);

  getListEvent(String token) {
    api.getListEvent(token).then((ListEventResponse listEventResponse) {
      _view.onGetDataSuccess(listEventResponse.data);
    }).catchError((Exception error) => _view.onGetDataFailed(error.toString()));
  }
}
