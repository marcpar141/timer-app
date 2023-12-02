abstract class TimerRepository {
  void startTimer();

  void stopTimer();

  Stream<int> observeTimer();
}
