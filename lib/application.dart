import 'package:fluro/fluro.dart';
import 'package:liulo/reducers/index.dart';
import 'package:liulo/data/index.dart';
import 'package:liulo/data/local/index.dart';
import 'package:liulo/data/remote/index.dart';
import 'package:liulo/repositories/index.dart';
import 'package:redux/redux.dart';
import 'package:path_provider/path_provider.dart';

class Application {
  static Router router;
  static Store<AppState> store;

  static const QuestionRepository questionRepository = const QuestionDataRepository(
    localDS: const QuestionLocalDataSource(
      '__redux_app__',
      getApplicationDocumentsDirectory,
    ),
    remoteDS: const QuestionRemoteDataSource(),
  );
}
