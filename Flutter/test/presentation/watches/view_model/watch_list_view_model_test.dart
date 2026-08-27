import 'package:all_chrono/core/constants/app_constants.dart';
import 'package:all_chrono/domain/usecases/get_watches.dart';
import 'package:all_chrono/presentation/watches/view_model/watch_list_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/test_data.dart';

void main() {
  group('WatchListViewModel', () {
    WatchListViewModel createViewModel({bool shouldFail = false}) {
      return WatchListViewModel(
        GetWatches(FakeWatchRepository(testWatches, shouldFail: shouldFail)),
      );
    }

    test('loads watches successfully', () async {
      final viewModel = createViewModel();

      await viewModel.loadWatches();

      expect(viewModel.status, WatchListStatus.success);
      expect(viewModel.filteredWatches, hasLength(3));
    });

    test('sets failure state when loading fails', () async {
      final viewModel = createViewModel(shouldFail: true);

      await viewModel.loadWatches();

      expect(viewModel.status, WatchListStatus.failure);
      expect(viewModel.errorMessage, AppStrings.loadWatchesError);
    });

    test('filters by debounced search query', () async {
      final viewModel = createViewModel();
      await viewModel.loadWatches();

      viewModel.setSearchInput('speed');
      expect(viewModel.filteredWatches, hasLength(3));

      await Future<void>.delayed(
        Duration(milliseconds: AppConstants.searchDebounceMs),
      );
      expect(viewModel.filteredWatches, hasLength(1));
      expect(viewModel.filteredWatches.first.model, 'Speedmaster');
    });

    test('returns search suggestions for input', () async {
      final viewModel = createViewModel();
      await viewModel.loadWatches();

      viewModel.setSearchInput('ro');
      expect(viewModel.searchSuggestions, contains('Rolex'));
      expect(viewModel.searchSuggestions, contains('Rolex Submariner'));
    });

    test('filters by make', () async {
      final viewModel = createViewModel();
      await viewModel.loadWatches();

      viewModel.setSelectedMake('Rolex');
      expect(viewModel.filteredWatches, hasLength(1));
      expect(viewModel.filteredWatches.first.make, 'Rolex');
    });

    test('selecting suggestion applies search immediately', () async {
      final viewModel = createViewModel();
      await viewModel.loadWatches();

      viewModel.selectSearchSuggestion('Omega Speedmaster');
      expect(viewModel.searchInput, 'Omega Speedmaster');
      expect(viewModel.filteredWatches, hasLength(1));
      expect(viewModel.filteredWatches.first.model, 'Speedmaster');
    });

    test('clearSearch resets input and query', () async {
      final viewModel = createViewModel();
      await viewModel.loadWatches();

      viewModel.selectSearchSuggestion('Rolex Submariner');
      viewModel.clearSearch();

      expect(viewModel.searchInput, isEmpty);
      expect(viewModel.searchQuery, isEmpty);
      expect(viewModel.filteredWatches, hasLength(3));
    });

    test('toggleViewMode switches layout mode', () async {
      final viewModel = createViewModel();
      expect(viewModel.isGridView, isTrue);

      viewModel.toggleViewMode();
      expect(viewModel.isGridView, isFalse);
    });
  });
}
