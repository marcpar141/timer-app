import 'package:timer_ui/features/timer/domain/repository/timer_repository.dart';

abstract class StartTimerUseCase {
  void execute();
}

class StartTimerUseCaseImpl implements StartTimerUseCase {
  final TimerRepository _repository;

  StartTimerUseCaseImpl(this._repository);

  @override
  void execute() {
    _repository.startTimer();
  }
}
