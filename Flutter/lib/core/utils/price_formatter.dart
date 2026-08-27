import 'package:intl/intl.dart';

import '../constants/app_constants.dart';

String formatPrice(int price, String currency) {
  final formatter = NumberFormat.currency(
    symbol: _currencySymbol(currency),
    decimalDigits: 0,
  );
  return formatter.format(price);
}

String _currencySymbol(String currency) {
  return switch (currency.toUpperCase()) {
    CurrencyCodes.usd => r'$',
    CurrencyCodes.eur => '€',
    CurrencyCodes.gbp => '£',
    _ => '$currency ',
  };
}
