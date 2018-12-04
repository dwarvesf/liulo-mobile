import 'package:liulo/data/rest_ds.dart';
import 'package:liulo/model/question.dart';

abstract class ListQuestionScreenContract {
  void onGetDataSuccess(List<Question> list);

  void onGetDataFailed(String error);
}

class ListQuestionPresenter {
  ListQuestionScreenContract _view;
  RestDatasource api = new RestDatasource();

  ListQuestionPresenter(this._view);

  void getListTopic(String token, int id) {
    api.getListQuestion(token, id).then((List<Question> listQuestionResponse) {
      _view.onGetDataSuccess(listQuestionResponse);
    })
        .catchError((Exception error) =>
        _view.onGetDataFailed(error.toString()));
  }

}
