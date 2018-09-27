import 'package:liulo/model/topic.dart';
import 'package:liulo/utils/data_util.dart';

abstract class ListTopicContract {
  void onGetDataSuccess(List<Topic> items);
}

class ListTopicPresenter {
  ListTopicContract _view;

  ListTopicPresenter(this._view);

  void fakeData() {
    _view.onGetDataSuccess(DataUtil.getFakeListTopic());
  }
}
