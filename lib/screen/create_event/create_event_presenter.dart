import 'dart:convert';

import 'package:liulo/data/rest_ds.dart';
import 'package:liulo/model/event.dart';
import 'package:liulo/model/request/create_event_request.dart';
import 'package:liulo/model/response/create_event_response.dart';

abstract class CreateEventContract {
  void onCreateSuccess(Event event);
  void onCreateFailed(String error);
}

class CreateEventPresenter {
  CreateEventContract _view;
  RestDatasource api = new RestDatasource();

  CreateEventPresenter(this._view);

  void createEvent(String name, String description, String token) {
    var createEventRequest = new CreateEventRequest(
        new EventItem(name, description));
    var body = json.encode(createEventRequest);
    api
        .createEvent(body, token)
        .then((CreateEventResponse createEventResponse) {
      _view.onCreateSuccess(createEventResponse.data);
    }).catchError((Exception error) => _view.onCreateFailed(error.toString()));
  }
}
