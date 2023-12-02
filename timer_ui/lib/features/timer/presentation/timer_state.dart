class TimerState {
  final int? secondsLeft;
  final TimerStatus timerStatus;

  TimerState(this.secondsLeft, this.timerStatus);

  TimerState copyWith({
    int? secondsLeft,
    TimerStatus? timerStatus,
  }) =>
      TimerState(
        secondsLeft ?? this.secondsLeft,
        timerStatus ?? this.timerStatus,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerState &&
          runtimeType == other.runtimeType &&
          secondsLeft == other.secondsLeft &&
          timerStatus == other.timerStatus;

  @override
  int get hashCode => secondsLeft.hashCode ^ timerStatus.hashCode;
}

enum TimerStatus { STOPPED, RUNNING }
