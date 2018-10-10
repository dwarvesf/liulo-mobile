import 'dart:async';

abstract class SqlDataSource<T> {
  Future<T> findById(int id);

  Future<T> insert(T item);

  Future<T> update(T item);

  Future<void> delete(T item);
}
