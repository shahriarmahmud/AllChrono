import '../entities/watch.dart';

abstract class WatchRepository {
  Future<List<Watch>> getWatches();
}
