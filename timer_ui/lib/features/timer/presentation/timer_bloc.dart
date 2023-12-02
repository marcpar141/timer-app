import 'dart:async';

import 'package:timer_ui/core/base_bloc.dart';
import 'package:timer_ui/features/timer/domain/usecase/observe_timer.dart';
import 'package:timer_ui/features/timer/domain/usecase/start_timer_usecase.dart';
import 'package:timer_ui/features/timer/domain/usecase/stop_timer_usecase.dart';
import 'package:timer_ui/features/timer/presentation/timer_state.dart';

class TimerBloc extends BaseBloc<TimerState> {
  final StartTimerUseCase _startTimerUseCase;
  final StopTimerUseCase _stopTimerUseCase;
  final ObserveTimerUseCase _observeTimerUseCase;
  StreamSubscription? _timerSubscription;

  TimerBloc(this._startTimerUseCase, this._stopTimerUseCase,
      this._observeTimerUseCase)
      : super(TimerState(null, TimerStatus.STOPPED));

  Future<void> startTimer() async {
    await _startTimerUseCase.execute();
    state = state.copyWith(timerStatus: TimerStatus.RUNNING);
    _timerSubscription = _observeTimerUseCase.execute().listen(
          (event) => state = state.copyWith(secondsLeft: event),
          onDone: () => _updateStatusToStopped(),
          onError: (_) => _updateStatusToStopped(),
        );
  }

  void stopTimer() {
    _stopTimerUseCase.execute();
    _updateStatusToStopped();
    _closeSubscription();
  }

  void _updateStatusToStopped() {
    state = state.copyWith(timerStatus: TimerStatus.STOPPED);
  }

  void _closeSubscription() {
    _timerSubscription?.cancel();
    _timerSubscription = null;
  }

  @override
  void dispose() {
    _closeSubscription();
    super.dispose();
  }
}
