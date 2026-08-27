import '../entities/watch.dart';
import '../repositories/watch_repository.dart';

class GetWatches {
  const GetWatches(this._repository);

  final WatchRepository _repository;

  Future<List<Watch>> call() => _repository.getWatches();
}
