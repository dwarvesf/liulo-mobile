import 'package:liulo/model/question.dart';
import 'package:liulo/utils/data_util.dart';

abstract class ListQuestionScreenContract {
  void onGetDataSuccess(List<Question> items);
}

class ListQuestionPresenter {
  ListQuestionScreenContract _view;

  ListQuestionPresenter(this._view);

  void fakeData() {
    _view.onGetDataSuccess(DataUtil.getFakeListQuestion());
  }
}
