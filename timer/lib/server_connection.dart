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
    print("connecttttt");
    _socket?.onConnecting((data) => print("connecting: $data"));
    _socket?.onConnect((data) => print("connected to: $address"));
    _socket?.onConnectError((data) => print("connect error :$data"));
    _socket?.onConnectTimeout((data) => print("connect timeout: $data"));
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
    _socket?.on(event, (data) => _controllers[event]?.add(data.toString()));
    return _controllers[event]?.stream.cast<String>() ?? const Stream.empty();
  }

  void sendMessage(String event, [dynamic data]) {
    _socket?.emit(event, data);
  }

  FutureOr<void> _closeConnection(String event) {
    _controllers[event]?.close();
    _controllers.remove(event);
    if (_controllers.isEmpty) {
      _socket?.dispose();
      _socket = null;
    }
  }
}
