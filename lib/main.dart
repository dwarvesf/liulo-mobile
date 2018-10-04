import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:liulo/application.dart';
import 'package:liulo/middlewares/index.dart';
import 'package:liulo/reducers/index.dart';
import 'package:liulo/routes.dart';
import 'package:redux/redux.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App() {
    _initRouter();
    _initStore();
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

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'LiuLo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      onGenerateRoute: Application.router.generator,
      initialRoute: Routes.root,
    );

    return StoreProvider(
      store: Application.store,
      child: app,
    );
  }
}
