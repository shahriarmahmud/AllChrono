import 'package:flutter/material.dart';

abstract final class AppConstants {
  static const appName = 'AllChrono';
  static const watchesAssetPath = 'lib/core/utils/watches.json';
  static const seedColor = Color(0xFF1A1A2E);

  static const searchDebounceMs = 350;
  static const maxSearchSuggestions = 8;
}

abstract final class AppStrings {
  static const searchHint = 'Search by make or model';
  static const listViewTooltip = 'List view';
  static const gridViewTooltip = 'Grid view';
  static const filterAll = 'All';
  static const retry = 'Retry';
  static const emptySearchResults = 'No watches match your search';
  static const genericError = 'Something went wrong.';
  static const loadWatchesError = 'Failed to load watches.';

  static const detailMake = 'Make';
  static const detailModel = 'Model';
  static const detailPrice = 'Price';
  static const detailCurrency = 'Currency';
  static const detailId = 'ID';

  static String watchCount(int count) =>
      '$count watch${count == 1 ? '' : 'es'}';
}

abstract final class WatchJsonKeys {
  static const id = 'id';
  static const make = 'make';
  static const model = 'model';
  static const price = 'price';
  static const currency = 'currency';
  static const imageUrl = 'imageUrl';
}

abstract final class CurrencyCodes {
  static const usd = 'USD';
  static const eur = 'EUR';
  static const gbp = 'GBP';
}
