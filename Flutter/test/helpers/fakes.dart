import 'package:all_chrono/data/datasources/watch_local_data_source.dart';
import 'package:all_chrono/data/models/watch_model.dart';
import 'package:all_chrono/domain/entities/watch.dart';
import 'package:all_chrono/domain/repositories/watch_repository.dart';

class FakeWatchRepository implements WatchRepository {
  FakeWatchRepository(this.watches, {this.shouldFail = false});

  final List<Watch> watches;
  final bool shouldFail;

  @override
  Future<List<Watch>> getWatches() async {
    if (shouldFail) {
      throw Exception('Failed to load watches');
    }
    return watches;
  }
}

class FakeWatchLocalDataSource implements WatchLocalDataSource {
  FakeWatchLocalDataSource(this.watches);

  final List<WatchModel> watches;

  @override
  Future<List<WatchModel>> loadWatches() async => watches;
}

class ThrowingWatchLocalDataSource implements WatchLocalDataSource {
  @override
  Future<List<WatchModel>> loadWatches() async {
    throw Exception('Asset not found');
  }
}
