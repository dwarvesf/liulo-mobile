import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

/// https://flutter.io/docs/cookbook/networking/web-sockets#directions
class AppSocket {
  bool isConnected = false;
  IOWebSocketChannel _channel;

  void connect(String socketUrl) {
    disconnect();
    _channel = IOWebSocketChannel.connect(socketUrl);
    isConnected = true;
    _channel.stream.listen(
      (message) {
        // receive new data
        print(message);
      },
      onDone: () {
        // explicit disconnected. ie. channel.sink.close()
        // or disconnected due to network failure (after some data received)
        isConnected = false;

        if (_channel.closeCode != status.normalClosure) {
          // auto reconnect
          Future.delayed(Duration(seconds: 5), () {
            connect(socketUrl);
          });
        }
      },
      onError: (error) {
        // disconnected due to network failure
        isConnected = false;

        // auto reconnect
        Future.delayed(Duration(seconds: 5), () {
          connect(socketUrl);
        });
      },
      cancelOnError: true,
    );
  }

  void disconnect() {
    if (_channel != null) {
      _channel.sink.close(status.normalClosure);
      _channel = null;
      isConnected = false;
    }
  }

  void send(String text) {
    if (_channel != null) _channel.sink.add(text);
  }
}
