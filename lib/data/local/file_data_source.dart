import 'dart:async';

abstract class FileDataSource<T> {
  Future<T> load();

  Future save(T data);

  Future clear();
}
