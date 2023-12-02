import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ServerConnection {
  final String address;
  IO.Socket? _socket;
  final Map<String, StreamController<String>> _controllers = {};

  ServerConnection(this.address);

  Future<void> connect() async {
    if (_socket != null && _socket?.connected == true) {
      return;
    }
    _socket = IO.io(address);
    _socket?.onConnect((data) => print("connected to: $address"));
  }

  void disconnect() {
    for (final entry in _controllers.entries) {
      _closeConnection(entry.key);
    }
  }

  Stream<String> observe(String event) {
    if (_controllers.containsKey(event)) {
      return _controllers[event]!.stream.cast<String>();
    }
    _controllers[event] = StreamController(
      onCancel: () => _closeConnection(event),
    );
    _socket?.on(event, (data) => _controllers[event]?.add(data));
    return _controllers[event]?.stream.cast<String>() ?? const Stream.empty();
  }

  void sendMessage(String message) {
    _socket?.emit(message);
  }

  FutureOr<void> _closeConnection(String event) {
    _controllers[event]?.close();
    _controllers.remove(event);
    if (_controllers.isEmpty) {
      _socket?.close();
      _socket = null;
    }
  }
}