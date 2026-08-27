import 'package:all_chrono/data/models/watch_model.dart';
import 'package:all_chrono/data/repositories/watch_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';
import '../../helpers/test_data.dart';

void main() {
  group('WatchRepositoryImpl', () {
    test('returns watches from local data source', () async {
      final repository = WatchRepositoryImpl(
        FakeWatchLocalDataSource([
          WatchModel(
            id: testWatchRolex.id,
            make: testWatchRolex.make,
            model: testWatchRolex.model,
            price: testWatchRolex.price,
            currency: testWatchRolex.currency,
            imageUrl: testWatchRolex.imageUrl,
          ),
        ]),
      );

      final watches = await repository.getWatches();

      expect(watches, hasLength(1));
      expect(watches.first.make, 'Rolex');
    });

    test('propagates data source failures', () {
      final repository =
          WatchRepositoryImpl(ThrowingWatchLocalDataSource());

      expect(repository.getWatches(), throwsException);
    });
  });
}
