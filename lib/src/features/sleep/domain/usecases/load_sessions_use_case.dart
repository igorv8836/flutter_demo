import '../../core/model/sleep_session.dart';
import '../sleep_repository.dart';

class LoadSessionsUseCase {
  const LoadSessionsUseCase({required SleepRepository repository}) : _repository = repository;

  final SleepRepository _repository;

  List<SleepSession> execute() => _repository.readSessions();
}
