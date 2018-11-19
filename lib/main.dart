import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:liulo/application.dart';
import 'package:liulo/constants/config.dart';
import 'package:liulo/data/local/question_local_ds.dart';
import 'package:liulo/data/location_repository.dart';
import 'package:liulo/data/question_repository.dart';
import 'package:liulo/data/remote/question_remote_ds.dart';
import 'package:liulo/data/socket_repository.dart';
import 'package:liulo/locales/app_localizations.dart';
import 'package:liulo/middlewares/index.dart';
import 'package:liulo/push_notif_controller.dart';
import 'package:liulo/reducers/index.dart';
import 'package:liulo/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App() {
    _initRepositories();
    _initRouter();
    _initStore();
    _initPushNotificationController();
  }

  _initRouter() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  _initStore() {
    final store = Store<AppState>(
      appReducer,
      initialState: AppState.initialState(),
      middleware: createStoreMiddleware(Application.questionRepository),
    );
    Application.store = store;
  }

  _initPushNotificationController() {
    Application.pushNotifController = PushNotificationController();
    Application.pushNotifController.init();
  }

  _initRepositories() {
    Application.socketRepository = FlutterSocketRepository(Config.SOCKET_URL, true);

    Application.locationRepository = FlutterLocationRepository();
    
    Application.questionRepository = FlutterQuestionRepository(
      localDS: QuestionLocalDataSource(
        '__redux_app__',
        getApplicationDocumentsDirectory,
      ),
      remoteDS: QuestionRemoteDataSource(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'LiuLo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      onGenerateRoute: Application.router.generator,
      initialRoute: Routes.root,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('he', 'IL'), // Hebrew
        const Locale('vi'), // Vietnamese
        // ... other locales the app supports
      ],
    );

    return StoreProvider(
      store: Application.store,
      child: app,
    );
  }
}
