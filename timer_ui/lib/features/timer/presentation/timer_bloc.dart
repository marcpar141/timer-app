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
      : super(TimerState(3600));

  void startTimer() {
    _startTimerUseCase.execute();
    _timerSubscription = _observeTimerUseCase.execute().listen((event) {
      state = TimerState(event);
    });
  }

  void stopTimer() {
    _stopTimerUseCase.execute();
    _closeSubscription();
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
