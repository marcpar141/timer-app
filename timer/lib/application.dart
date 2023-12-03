import 'dart:convert';

import 'package:timer/server_connection.dart';
import 'package:timer/timer.dart';

class Application {
  final ServerConnection _connection;
  final Map<String, Timer> _timer = {};

  Application()
      : _connection = ServerConnection(
          "ws://server:5000/timer",
          // IO.OptionBuilder()
          //     .setExtraHeaders({"client": "timer_service"}).build(),
        );

  Future<void> start() async {
    _connection.connect();

    _startObservingSocket();
  }

  void _startObservingSocket() {
    _connection.observe("control").listen((event) {
      print("control -> received: $event");
      final message = jsonDecode(event);
      final command = message["command"] as String?;
      final roomName = message["roomName"] as String?;

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
            _connection.sendMessage(
                "state", jsonEncode({"time": time, "roomName": roomName}));
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
