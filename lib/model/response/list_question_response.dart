import 'package:liulo/model/question.dart';

class ListQuestionResponse {
  List<Question> data;

  ListQuestionResponse({this.data});

  ListQuestionResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Question>();
      json['data'].forEach((v) {
        data.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
