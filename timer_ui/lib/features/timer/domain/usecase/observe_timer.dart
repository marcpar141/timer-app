import 'package:timer_ui/features/timer/domain/repository/timer_repository.dart';

abstract class ObserveTimerUseCase {
  Stream<int> execute();
}

class ObserveTimerUseCaseImpl implements ObserveTimerUseCase {
  final TimerRepository _repository;

  ObserveTimerUseCaseImpl(this._repository);

  @override
  Stream<int> execute() {
    return _repository.observeTimer();
  }
}
