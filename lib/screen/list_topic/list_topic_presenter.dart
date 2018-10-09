import 'dart:convert';

import 'package:liulo/data/rest_ds.dart';
import 'package:liulo/model/request/create_topic_request.dart';
import 'package:liulo/model/response/create_topic_response.dart';
import 'package:liulo/model/response/list_topic_response.dart';
import 'package:liulo/model/topic.dart';

abstract class ListTopicContract {

  void onGetDataSuccess(List<Topic> items);

  void onGetDataFailed(String error);

  void onCreateSuccess(Topic topic);

  void onCreateFailed(String error);

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

  void createTopic(String name, String description, String speakerName,
      int eventId, String token) {
    var createTopicRequest = new CreateTopicRequest(
        eventId, new TopicRequest(name, description, speakerName));
    var body = json.encode(createTopicRequest);
    api
        .createTopic(body, token)
        .then((CreateTopicResponse createTopicResponse) {
      _view.onCreateSuccess(createTopicResponse.data);
    }).catchError((Exception error) => _view.onCreateFailed(error.toString()));
  }
}
