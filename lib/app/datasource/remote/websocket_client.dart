import "package:stomp_dart_client/stomp_dart_client.dart";

class WebsocketClient {
  late final StompClient _client;
  bool isConnected = false;

  WebsocketClient() {
    _client = StompClient(
      config: StompConfig(
        url: "wss://yourserver",
        onConnect: (StompFrame connectFrame) => isConnected = true,
        onDisconnect: (StompFrame connectFrame) => isConnected = false,
      ),
    );
  }

  StompClient get client => _client;
}
