import 'package:all_chrono/core/constants/app_constants.dart';
import 'package:all_chrono/core/utils/price_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatPrice', () {
    test('formats USD prices', () {
      expect(formatPrice(14500, CurrencyCodes.usd), r'$14,500');
    });

    test('formats EUR prices', () {
      expect(formatPrice(4800, CurrencyCodes.eur), '€4,800');
    });

    test('formats GBP prices', () {
      expect(formatPrice(3200, CurrencyCodes.gbp), '£3,200');
    });

    test('falls back to currency code prefix for unknown currencies', () {
      expect(formatPrice(1000, 'JPY'), 'JPY 1,000');
    });
  });
}
