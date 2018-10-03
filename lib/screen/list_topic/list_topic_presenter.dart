import 'package:liulo/data/rest_ds.dart';
import 'package:liulo/model/response/list_topic_response.dart';
import 'package:liulo/model/topic.dart';

abstract class ListTopicContract {
  void onGetDataSuccess(List<Topic> items);

  void onGetDataFailed(String error);
}

class ListTopicPresenter {
  ListTopicContract _view;
  RestDatasource api = new RestDatasource();

  ListTopicPresenter(this._view);

  void getListTopic(String token, int id) {
    api.getListTopic(token, id).then((ListTopicResponse listTopicResponse) {
      _view.onGetDataSuccess(listTopicResponse.data);
    }).catchError((Exception error) => _view.onGetDataFailed(error.toString()));
  }
}
