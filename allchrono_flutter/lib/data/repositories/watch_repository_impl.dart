import '../../domain/entities/watch.dart';
import '../../domain/repositories/watch_repository.dart';
import '../datasources/watch_local_data_source.dart';

class WatchRepositoryImpl implements WatchRepository {
  const WatchRepositoryImpl(this._localDataSource);

  final WatchLocalDataSource _localDataSource;

  @override
  Future<List<Watch>> getWatches() => _localDataSource.loadWatches();
}
