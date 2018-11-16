import 'package:firebase_messaging/firebase_messaging.dart';

/// https://pub.dartlang.org/documentation/firebase_messaging/latest/

class PushNotificationController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void init() {
    // for ios only
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.configure(
      onMessage: _onMessage,
      onLaunch: _onLaunch,
      onResume: _onResume,
    );

    getToken().then(_onTokenRefresh);
    _firebaseMessaging.onTokenRefresh.listen(_onTokenRefresh);
  }

  Future<String> getToken() {
    return _firebaseMessaging.getToken();
  }

  Future<dynamic> _onMessage(Map<String, dynamic> data) {
    data.forEach((key, value) {
      if (key == "notification") {
        value["title"];
        value["body"];
      }
      if (key == "data") {
        value.forEach((key, value) {});
      }
    });
    return Future.value(null);
  }

  Future<dynamic> _onLaunch(Map<String, dynamic> data) {
    return Future.value(null);
  }

  Future<dynamic> _onResume(Map<String, dynamic> data) {
    return Future.value(null);
  }

  void _onTokenRefresh(String token) {
    // TODO upload token to server
    print(token);
  }
}
