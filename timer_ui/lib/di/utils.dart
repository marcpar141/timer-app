import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:timer_ui/utils/server_connection.dart';

final utils = [
  Dependency((i) => ServerConnection(
        "ws://192.168.1.108:5000/timer", {}
      // IO.OptionBuilder().setTransports(["websocket"]).build(),
      )),
];
