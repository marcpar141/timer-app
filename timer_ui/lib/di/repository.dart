import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:timer_ui/features/timer/data/repository/timer_repository.dart';
import 'package:timer_ui/features/timer/domain/repository/timer_repository.dart';

final repositories = [
  Dependency<TimerRepository>((i) => TimerRepositoryImpl(i.getDependency())),
];
