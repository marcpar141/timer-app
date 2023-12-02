import 'package:timer/extensions/let_extension.dart';
import 'package:timer/socket.dart';
import 'package:timer/timer.dart';

class Application {
  ServerConnection? _connection;
  Timer? _timer;

  void start() {
    _connection = ServerConnection("address")..connect();

    _connection?.observe().listen((event) {
      if (event == "start") {
        _startTimer();
      } else if (event == "stop") {
        _stopTimer();
      }
    });
  }

  void _startTimer() {
    _stopTimer();
    _timer =
        Timer(period: Duration(seconds: 1), duration: Duration(seconds: 3600))
          ..addListener(() {
            _connection?.sendMessage("elo");
          })
          ..startTimer();
  }

  void _stopTimer() {
    _timer?.let((it) {
      it.stopTimer();
      it.removeListeners();
      _timer = null;
    });
  }
}
