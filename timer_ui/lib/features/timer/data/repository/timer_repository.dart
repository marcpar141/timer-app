import 'package:timer_ui/features/timer/domain/repository/timer_repository.dart';
import 'package:timer_ui/utils/websocket.dart';

class TimerRepositoryImpl implements TimerRepository {
  final ServerConnection _connection;

  TimerRepositoryImpl(this._connection);

  @override
  Stream<int> observeTimer() {
    return _connection
        .observe()
        .where((event) => int.tryParse(event) != null)
        .map((event) => int.parse(event));
  }

  @override
  void startTimer() {
    _connection.connect();
    _connection.sendMessage("start");
  }

  @override
  void stopTimer() {
    _connection.sendMessage("stop");
  }
}
