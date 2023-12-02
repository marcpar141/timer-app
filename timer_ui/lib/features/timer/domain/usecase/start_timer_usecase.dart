import 'package:timer_ui/features/timer/domain/repository/timer_repository.dart';

abstract class StartTimerUseCase {
  Future<void> execute();
}

class StartTimerUseCaseImpl implements StartTimerUseCase {
  final TimerRepository _repository;

  StartTimerUseCaseImpl(this._repository);

  @override
  Future<void> execute() => _repository.startTimer();
}
