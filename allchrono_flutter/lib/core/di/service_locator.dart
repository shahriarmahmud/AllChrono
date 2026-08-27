import '../../data/datasources/watch_local_data_source.dart';
import '../../data/repositories/watch_repository_impl.dart';
import '../../domain/usecases/get_watches.dart';

class ServiceLocator {
  ServiceLocator._();

  static final ServiceLocator instance = ServiceLocator._();

  late final GetWatches getWatches;

  void init() {
    final localDataSource = WatchLocalDataSourceImpl();
    final repository = WatchRepositoryImpl(localDataSource);
    getWatches = GetWatches(repository);
  }
}
