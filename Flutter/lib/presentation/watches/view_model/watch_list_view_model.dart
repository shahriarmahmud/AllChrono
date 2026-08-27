import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/constants/app_constants.dart';
import '../../../domain/entities/watch.dart';
import '../../../domain/usecases/get_watches.dart';

enum WatchListStatus { initial, loading, success, failure }

class WatchListViewModel extends ChangeNotifier {
  WatchListViewModel(this._getWatches);

  final GetWatches _getWatches;

  static final _debounceDuration =
      Duration(milliseconds: AppConstants.searchDebounceMs);

  WatchListStatus _status = WatchListStatus.initial;
  String? _errorMessage;
  List<Watch> _watches = [];
  String _searchInput = '';
  String _searchQuery = '';
  String? _selectedMake;
  bool _isGridView = true;
  Timer? _debounceTimer;

  WatchListStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isGridView => _isGridView;
  String get searchInput => _searchInput;
  String get searchQuery => _searchQuery;
  String? get selectedMake => _selectedMake;

  List<String> get makes {
    final uniqueMakes = _watches.map((watch) => watch.make).toSet().toList();
    uniqueMakes.sort();
    return uniqueMakes;
  }

  List<String> get searchSuggestions {
    final query = _searchInput.trim().toLowerCase();
    if (query.isEmpty) return const [];

    final suggestions = <String>{};

    for (final watch in _watches) {
      final make = watch.make;
      final model = watch.model;
      final fullName = '$make $model';
      final makeLower = make.toLowerCase();
      final modelLower = model.toLowerCase();
      final fullLower = fullName.toLowerCase();

      if (makeLower.contains(query)) {
        suggestions.add(make);
      }
      if (modelLower.contains(query)) {
        suggestions.add(fullName);
      }
      if (fullLower.contains(query)) {
        suggestions.add(fullName);
      }
    }

    final sorted = suggestions.toList()..sort();
    return sorted.take(AppConstants.maxSearchSuggestions).toList();
  }

  List<Watch> get filteredWatches {
    final query = _searchQuery.trim().toLowerCase();

    return _watches.where((watch) {
      final matchesMake =
          _selectedMake == null || watch.make == _selectedMake;
      final matchesQuery = query.isEmpty ||
          watch.make.toLowerCase().contains(query) ||
          watch.model.toLowerCase().contains(query) ||
          '${watch.make} ${watch.model}'.toLowerCase().contains(query);
      return matchesMake && matchesQuery;
    }).toList();
  }

  Future<void> loadWatches() async {
    _status = WatchListStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _watches = await _getWatches();
      _status = WatchListStatus.success;
    } catch (error) {
      _status = WatchListStatus.failure;
      _errorMessage = AppStrings.loadWatchesError;
      debugPrint('WatchListViewModel.loadWatches: $error');
    }

    notifyListeners();
  }

  void setSearchInput(String input) {
    if (_searchInput == input) return;

    _searchInput = input;
    notifyListeners();

    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, () {
      if (_searchQuery == input) return;
      _searchQuery = input;
      notifyListeners();
    });
  }

  void selectSearchSuggestion(String suggestion) {
    _debounceTimer?.cancel();
    _searchInput = suggestion;
    _searchQuery = suggestion;
    notifyListeners();
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    _searchInput = '';
    _searchQuery = '';
    notifyListeners();
  }

  void setSelectedMake(String? make) {
    if (_selectedMake == make) return;
    _selectedMake = make;
    notifyListeners();
  }

  void toggleViewMode() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
