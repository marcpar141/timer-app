import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:timer_ui/features/timer/domain/usecase/observe_timer.dart';
import 'package:timer_ui/features/timer/domain/usecase/start_timer_usecase.dart';
import 'package:timer_ui/features/timer/domain/usecase/stop_timer_usecase.dart';

final usecases = [
  Dependency((i) => StartTimerUseCaseImpl(i.getDependency())),
  Dependency((i) => StopTimerUseCaseImpl(i.getDependency())),
  Dependency((i) => ObserveTimerUseCaseImpl(i.getDependency())),
];
