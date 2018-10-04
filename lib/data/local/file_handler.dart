import 'dart:async';

import 'dart:io';

class FileHandler {
  static Future<File> getLocalFile(String tag, Function getDirectory) async {
    final dir = await getDirectory();

    return File('${dir.path}/file_storage__$tag.json');
  }
}
