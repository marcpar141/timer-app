import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ServerConnection {
  final String address;
  IO.Socket? _socket;
  final Map<String, dynamic> _options;
  final Map<String, StreamController<dynamic>> _controllers = {};

  ServerConnection(this.address, this._options);

  Future<void> connect() async {
    if (_socket != null && _socket?.connected == true) {
      return;
    }
    final completer = Completer();
    _socket = IO.io(address, _options);
    _socket?.onConnect((data) {
      print("connected to: $address");
      completer.complete();
    });
    _socket?.onConnectError((data) => print("connect error :$data"));
    _socket?.onConnectTimeout((data) => print("connect timeout: $data"));
    return completer.future;
  }

  void disconnect() {
    for (final entry in _controllers.entries) {
      _closeConnection(entry.key);
    }
  }

  Stream<dynamic> observe(String event) {
    print("observing event: $event");
    if (_controllers.containsKey(event)) {
      return _controllers[event]!.stream;
    }
    _controllers[event] = StreamController(
      onCancel: () => _closeConnection(event),
    );
    _socket?.on(event, (data) => _controllers[event]?.add(data));
    return _controllers[event]?.stream ?? const Stream.empty();
  }

  void sendMessage(String event, [dynamic data]) {
    print("sending event: $event, with data: $data");
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
