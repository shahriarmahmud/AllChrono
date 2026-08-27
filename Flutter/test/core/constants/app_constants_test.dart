import 'package:all_chrono/core/constants/app_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppStrings', () {
    test('watchCount uses singular for one item', () {
      expect(AppStrings.watchCount(1), '1 watch');
    });

    test('watchCount uses plural for multiple items', () {
      expect(AppStrings.watchCount(2), '2 watches');
      expect(AppStrings.watchCount(0), '0 watches');
    });
  });
}
