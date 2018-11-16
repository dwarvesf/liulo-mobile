import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:liulo/data/local/file_data_source.dart';
import 'package:liulo/data/local/file_handler.dart';
import 'package:liulo/models/question.dart';

/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `tag` variable and the `getDirectory` method should be injected. This allows for testing.
class QuestionLocalDataSource implements FileDataSource<List<Question>> {
  final String tag;
  final Future<Directory> Function() getDirectory;

  QuestionLocalDataSource(this.tag, this.getDirectory);

  @override
  Future<List<Question>> load() async {
    final file = await FileHandler.getLocalFile(tag, getDirectory);
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final questions = (json['questions']).map<Question>((question) => Question.fromJson(question)).toList();

    return questions;
  }

  @override
  Future save(List<Question> data) async {
    final file = await FileHandler.getLocalFile(tag, getDirectory);

    return file.writeAsString(JsonEncoder().convert({
      'questions': data.map((question) => question.toJson()).toList(),
    }));
  }

  @override
  Future clear() async {
    final file = await FileHandler.getLocalFile(tag, getDirectory);

    return file.delete();
  }
}
