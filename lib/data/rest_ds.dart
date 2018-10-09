import 'dart:async';
import 'dart:collection';

import 'package:liulo/model/response/create_event_response.dart';
import 'package:liulo/model/response/create_topic_response.dart';
import 'package:liulo/model/response/list_event_response.dart';
import 'package:liulo/model/response/list_topic_response.dart';
import 'package:liulo/model/response/login_response.dart';
import 'package:liulo/utils/network_util.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://192.168.40.156:4000/api/v1";
  static final LOGIN_URL = BASE_URL + "/login_google";
  static final LIST_EVENT = BASE_URL + "/event";
  static final TOPIC = BASE_URL + "/topic";
  Future<LoginResponse> login(String body) {
    return _netUtil
        .post(LOGIN_URL, body: body, headers: getHeadersNonToken())
        .then((dynamic res) {
      print(res.toString());
      if (res["error"] != null && res["error"])
        throw new Exception(res["error_msg"]);
      var loginResponse = new LoginResponse();
      loginResponse = LoginResponse.fromJson(res);
      if (loginResponse != null) return loginResponse;
    });
  }

  Future<ListEventResponse> getListEvent(String token) {
    return _netUtil
        .get(LIST_EVENT, headersGet: getHeaders(token))
        .then((dynamic res) {
      print(res.toString());
      if (res["error"] != null && res["error"])
        throw new Exception(res["error_msg"]);
      var listEventResponse = new ListEventResponse();
      listEventResponse = ListEventResponse.fromJson(res);
      if (listEventResponse != null) return listEventResponse;
    });
  }

  Future<ListTopicResponse> getListTopic(String token, int id) {
    var link = '${LIST_EVENT}/${id}/topic';
    return _netUtil
        .get(link, headersGet: getHeaders(token))
        .then((dynamic res) {
      print(res.toString());
      if (res["error"] != null && res["error"])
        throw new Exception(res["error_msg"]);
      var listTopicResponse = new ListTopicResponse();
      listTopicResponse = ListTopicResponse.fromJson(res);
      if (listTopicResponse != null) return listTopicResponse;
    });
  }

  Future<CreateEventResponse> createEvent(String body, String token) {
    return _netUtil
        .post(LIST_EVENT, body: body, headers: getHeaders(token))
        .then((dynamic res) {
      print(res.toString());
      if (res["error"] != null && res["error"])
        throw new Exception(res["error_msg"]);
      var createEventResponse = new CreateEventResponse();
      createEventResponse = CreateEventResponse.fromJson(res);
      if (createEventResponse != null) return createEventResponse;
    });
  }

  Future<CreateTopicResponse> createTopic(String body, String token) {
    return _netUtil
        .post(TOPIC, body: body, headers: getHeaders(token))
        .then((dynamic res) {
      print(res.toString());
      if (res["error"] != null && res["error"])
        throw new Exception(res["error_msg"]);
      var createTopicResponse = new CreateTopicResponse();
      createTopicResponse = CreateTopicResponse.fromJson(res);
      if (createTopicResponse != null) return createTopicResponse;
    });
  }

  Map<String, String> getHeaders(String token) {
    var authorization = 'Bearer ${token}';
    Map<String, String> headers = new HashMap();
    headers['Authorization'] = authorization;
    headers['Content-Type'] = " application/json; charset=utf-8";

    return headers;
  }

  Map<String, String> getHeadersNonToken() {
    Map<String, String> headers = new HashMap();
    headers['Content-Type'] = " application/json; charset=utf-8";
    return headers;
  }
}
