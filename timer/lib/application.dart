import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:timer/server_connection.dart';
import 'package:timer/timer.dart';

class Application {
  final ServerConnection _connection;
  final Map<String, Timer> _timer = {};

  Application()
      : _connection = ServerConnection(
            "ws://192.168.1.108:5000/timer",
            IO.OptionBuilder()
                .disableAutoConnect()
                .setExtraHeaders({"client": "timer_service"}).build());

  Future<void> start() async {
    await _connection.connect();

    _connection.observe("control").listen((event) {
      final message = jsonDecode(event) as Map<String, String>;
      final command = message["command"];
      final roomName = message["roomName"];

      if (command == null || roomName == null) {
        return;
      }

      if (command == "start") {
        _startTimer(roomName);
      } else if (command == "stop") {
        _stopTimer(roomName);
      }
    });
  }

  void _startTimer(String roomName) {
    _stopTimer(roomName);
    _timer[roomName] =
        Timer(period: Duration(seconds: 1), duration: Duration(seconds: 10))
          ..addListener((time) {
            _connection.sendMessage("state", time);
          })
          ..startTimer();
  }

  void _stopTimer(String roomName) {
    _timer[roomName]
      ?..stopTimer()
      ..removeListeners();
    _timer.remove(roomName);
  }
}
