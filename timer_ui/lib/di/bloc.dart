import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:timer_ui/features/timer/presentation/timer_bloc.dart';

final blocs = [
  Bloc(
    (i) => TimerBloc(
      i.getDependency(),
      i.getDependency(),
      i.getDependency(),
    ),
  ),
];
