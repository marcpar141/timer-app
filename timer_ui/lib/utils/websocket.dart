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
    print("connecting to $address");
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse(address),
      );
    } catch (e) {
      print("error connecting $e");
    }
  }

  Stream<String> observe() {
    print("start observing");
    return _channel?.stream.map((event) {
          print("observing: $event");
          return event;
        }).cast<String>() ??
        const Stream.empty();
  }

  void sendMessage(String message) {
    _channel?.sink.add(message);
  }
}
