import 'dart:io';

import 'package:web_socket_channel/web_socket_channel.dart';

class ServerConnection {
  final String address;
  WebSocketChannel? _channel;

  ServerConnection(this.address);

  void connect() {
    if (_channel != null) {
      _channel?.sink.close(
          WebSocketStatus.abnormalClosure, "connecting again to channel");
    }
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://echo.websocket.events'),
    );
  }

  Stream<String> observe() => _channel?.stream.cast<String>() ?? Stream.empty();

  void sendMessage(String message) {
    _channel?.sink.add(message);
  }
}
