typedef OnMessageCallback(String message);

abstract class SocketRepository {

  bool isConnected();

  void connect();

  void disconnect();

  void send(String message);

  int subscribe(OnMessageCallback callback);

  void unsubscribe(int id);
}
