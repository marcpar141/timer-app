import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:timer_ui/utils/server_connection.dart';

final utils = [
  Dependency((i) => ServerConnection("ws://server:5000/timer")),
];
