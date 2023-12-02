class TimerState {
  final int secondsLeft;

  TimerState(this.secondsLeft);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerState &&
          runtimeType == other.runtimeType &&
          secondsLeft == other.secondsLeft;

  @override
  int get hashCode => secondsLeft.hashCode;
}
