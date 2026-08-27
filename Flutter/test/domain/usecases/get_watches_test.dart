import 'package:all_chrono/domain/usecases/get_watches.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';
import '../../helpers/test_data.dart';

void main() {
  group('GetWatches', () {
    test('delegates to repository', () async {
      final useCase = GetWatches(FakeWatchRepository(testWatches));

      final watches = await useCase();

      expect(watches, testWatches);
    });
  });
}
