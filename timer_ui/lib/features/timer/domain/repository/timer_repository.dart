abstract class TimerRepository {
  Future<void> startTimer();

  void stopTimer();

  Stream<int> observeTimer();
}
