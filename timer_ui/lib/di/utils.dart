import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:timer_ui/utils/websocket.dart';

final utils = [
  Dependency((i) => ServerConnection("address")),
];
