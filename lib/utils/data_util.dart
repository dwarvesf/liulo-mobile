import 'package:liulo/model/event.dart';
import 'package:liulo/model/question.dart';

class DataUtil {
  static List<Question> getFakeListQuestion() {
    List<Question> items = new List();
    items.add(new Question(
      1,
      2,
      'Aesymnetes',
      'If you didn’t have to sleep, what would you do with the extra time?',
    ));
    items.add(new Question(
      2,
      3,
      'Air Marshal',
      'What’s your favorite piece of clothing you own / owned?',
    ));
    items.add(new Question(
      3,
      4,
      'Ephor',
      'What hobby would you get into if time and money weren’t an issue?',
    ));
    items.add(new Question(
      4,
      5,
      'Hierodeacon',
      'What would your perfect room look like?',
    ));
    items.add(new Question(
      5,
      6,
      'Hierophant',
      'If you could turn any activity into an Olympic sport, what would you have a good chance at winning medal for?',
    ));
    items.add(new Question(
      6,
      7,
      'Primate',
      'What would be your first question after waking up from being cryogenically frozen for 100 years?',
    ));
    items.add(new Question(
      7,
      8,
      'Voivode',
      'What is something that is considered a luxury, but you don’t think you could live without?',
    ));
    return items;
  }
  static List<Event> getFakeListEvent() {
    List<Event> items = new List();
    items.add(new Event(
        "active",
        "",
        "Test event",
        2,
        "",
        "This is test event 2",
        "DLXY"));
    items.add(new Event(
        "active",
        "",
        "Test event",
        2,
        "",
        "This is test event 2",
        "DLXY"));
    items.add(new Event(
        "active",
        "",
        "Test event",
        2,
        "",
        "This is test event 2",
        "DLXY"));
    items.add(new Event(
        "active",
        "",
        "Test event",
        2,
        "",
        "This is test event 2",
        "DLXY"));
    items.add(new Event(
        "active",
        "",
        "Test event",
        2,
        "",
        "This is test event 2",
        "DLXY"));
    items.add(new Event(
        "active",
        "",
        "Test event",
        2,
        "",
        "This is test event 2",
        "DLXY"));
    items.add(new Event(
        "active",
        "",
        "Test event",
        2,
        "",
        "This is test event 2",
        "DLXY"));
    items.add(new Event(
        "active",
        "",
        "Test event",
        2,
        "",
        "This is test event 2",
        "DLXY"));
    return items;
  }
}
