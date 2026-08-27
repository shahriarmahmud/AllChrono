import 'package:all_chrono/data/models/watch_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_data.dart';

void main() {
  group('WatchModel', () {
    test('fromJson maps all fields correctly', () {
      final watch = WatchModel.fromJson(testWatchJson);

      expect(watch.id, testWatchRolex.id);
      expect(watch.make, testWatchRolex.make);
      expect(watch.model, testWatchRolex.model);
      expect(watch.price, testWatchRolex.price);
      expect(watch.currency, testWatchRolex.currency);
      expect(watch.imageUrl, testWatchRolex.imageUrl);
    });
  });
}
