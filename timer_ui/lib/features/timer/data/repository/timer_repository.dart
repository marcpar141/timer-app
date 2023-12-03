import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:timer_ui/features/timer/domain/repository/timer_repository.dart';
import 'package:timer_ui/utils/server_connection.dart';

class TimerRepositoryImpl extends Disposable implements TimerRepository {
  final ServerConnection _connection;

  TimerRepositoryImpl(this._connection);

  @override
  Stream<int> observeTimer() {
    return _connection
        .observe("state")
        .where((event) => int.tryParse(event) != null)
        .map((event) => int.parse(event));
  }

  @override
  Future<void> startTimer() async {
    await _connection.connect();
  }

  @override
  void stopTimer() {
    _connection.disconnect();
  }

  @override
  void dispose() {
    _connection.disconnect();
  }
}
