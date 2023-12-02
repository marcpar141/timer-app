import 'package:timer_ui/features/timer/domain/repository/timer_repository.dart';

abstract class StopTimerUseCase {
  void execute();
}

class StopTimerUseCaseImpl implements StopTimerUseCase {
  final TimerRepository _repository;

  StopTimerUseCaseImpl(this._repository);

  @override
  void execute() {
    _repository.stopTimer();
  }
}
