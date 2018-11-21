import 'package:fluro/fluro.dart';
import 'package:liulo/push_notif_controller.dart';
import 'package:liulo/reducers/index.dart';
import 'package:liulo/repositories/index.dart';
import 'package:liulo/repositories/location_repository.dart';
import 'package:liulo/repositories/socket_repository.dart';
import 'package:redux/redux.dart';


class Application {
  static Router router;
  static Store<AppState> store;
  static PushNotificationController pushNotifController;
  static SocketRepository socketRepository;
  static QuestionRepository questionRepository;
  static LocationRepository locationRepository;
}
