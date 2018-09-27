import 'package:liulo/model/post.dart';

abstract class ManageEventScreenContract {
  void onGetDataSuccess(List<Post> items);
}

class ManageEventPresenter {
  ManageEventScreenContract _view;

  ManageEventPresenter(this._view);

  void fakeData() {
    List<Post> items = new List();
    items.add(new Post(
      1,
      2,
      'Aesymnetes',
      'If you didn’t have to sleep, what would you do with the extra time?',
    ));
    items.add(new Post(
      2,
      3,
      'Air Marshal',
      'What’s your favorite piece of clothing you own / owned?',
    ));
    items.add(new Post(
      3,
      4,
      'Ephor',
      'What hobby would you get into if time and money weren’t an issue?',
    ));
    items.add(new Post(
      4,
      5,
      'Hierodeacon',
      'What would your perfect room look like?',
    ));
    items.add(new Post(
      5,
      6,
      'Hierophant',
      'If you could turn any activity into an Olympic sport, what would you have a good chance at winning medal for?',
    ));
    items.add(new Post(
      6,
      7,
      'Primate',
      'What would be your first question after waking up from being cryogenically frozen for 100 years?',
    ));
    items.add(new Post(
      7,
      8,
      'Voivode',
      'What is something that is considered a luxury, but you don’t think you could live without?',
    ));
    _view.onGetDataSuccess(items);
  }
}
