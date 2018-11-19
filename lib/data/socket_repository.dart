import 'dart:async';

import 'package:liulo/repositories/socket_repository.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

/// https://flutter.io/docs/cookbook/networking/web-sockets#directions
class FlutterSocketRepository implements SocketRepository {
  bool _isConnected = false;
  String _url = "";
  bool _autoReconnect = false;
  IOWebSocketChannel _channel;
  Map<int, OnMessageCallback> _callbacks = const {};

  FlutterSocketRepository(String url, bool autoReconnect)
      : _url = url,
        _autoReconnect = autoReconnect;

  @override
  bool isConnected() => _isConnected;

  @override
  void connect() {
    disconnect();
    _channel = IOWebSocketChannel.connect(_url);
    _isConnected = true;
    _channel.stream.listen(
      (message) {
        // receive new data
        _callbacks.forEach((_, callback) {
          callback(message);
        });
      },
      onDone: () {
        // explicit disconnected. ie. channel.sink.close()
        // or disconnected due to network failure (after some data received)
        _isConnected = false;

        if (_channel.closeCode != status.normalClosure) {
          if (_autoReconnect) {
            Future.delayed(Duration(seconds: 5), () {
              connect();
            });
          }
        }
      },
      onError: (error) {
        // disconnected due to network failure
        _isConnected = false;
        
        if (_autoReconnect) {
          Future.delayed(Duration(seconds: 5), () {
            connect();
          });
        }
      },
      cancelOnError: true,
    );
  }

  @override
  void disconnect() {
    if (_channel != null) {
      _channel.sink.close(status.normalClosure);
      _channel = null;
      _isConnected = false;
    }
  }

  @override
  void send(String message) {
    if (_channel != null) _channel.sink.add(message);
  }

  @override
  int subscribe(OnMessageCallback callback) {
    int id = DateTime.now().millisecondsSinceEpoch;
    _callbacks[id] = callback;
    return id;
  }

  @override
  void unsubscribe(int id) {
    _callbacks.remove(id);
  }
}
