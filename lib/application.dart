import 'package:fluro/fluro.dart';
import 'package:liulo/push_notif_controller.dart';
import 'package:liulo/reducers/index.dart';
import 'package:liulo/data/index.dart';
import 'package:liulo/data/local/index.dart';
import 'package:liulo/data/remote/index.dart';
import 'package:liulo/repositories/index.dart';
import 'package:liulo/socket.dart';
import 'package:redux/redux.dart';
import 'package:path_provider/path_provider.dart';

class Application {
  static Router router;
  static Store<AppState> store;
  static PushNotificationController pushNotifController;
  static AppSocket appSocket;

  static QuestionRepository questionRepository = QuestionDataRepository(
    localDS: QuestionLocalDataSource(
      '__redux_app__',
      getApplicationDocumentsDirectory,
    ),
    remoteDS: QuestionRemoteDataSource(),
  );
}
