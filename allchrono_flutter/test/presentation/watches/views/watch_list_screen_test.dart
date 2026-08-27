import 'package:all_chrono/core/constants/app_constants.dart';
import 'package:all_chrono/domain/usecases/get_watches.dart';
import 'package:all_chrono/presentation/watches/view_model/watch_list_view_model.dart';
import 'package:all_chrono/presentation/watches/views/watch_detail_screen.dart';
import 'package:all_chrono/presentation/watches/views/watch_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/test_data.dart';

Finder filterChip(String label) => find.widgetWithText(FilterChip, label);

void main() {
  group('WatchListScreen', () {
    Future<WatchListViewModel> pumpLoadedScreen(
      WidgetTester tester, {
      bool shouldFail = false,
    }) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final viewModel = WatchListViewModel(
        GetWatches(FakeWatchRepository(testWatches, shouldFail: shouldFail)),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: WatchListScreen(viewModel: viewModel),
        ),
      );
      await tester.pump();
      await viewModel.loadWatches();
      await tester.pump();

      return viewModel;
    }

    testWidgets('shows app title and loaded watches', (tester) async {
      await pumpLoadedScreen(tester);

      expect(find.text(AppConstants.appName), findsOneWidget);
      expect(find.text('Submariner'), findsOneWidget);
      expect(find.text(AppStrings.watchCount(3)), findsOneWidget);
    });

    testWidgets('shows search bar hint', (tester) async {
      await pumpLoadedScreen(tester);

      expect(find.text(AppStrings.searchHint), findsOneWidget);
    });

    testWidgets('shows make filter chips', (tester) async {
      await pumpLoadedScreen(tester);

      expect(filterChip(AppStrings.filterAll), findsOneWidget);
      expect(filterChip('Cartier'), findsOneWidget);
      expect(filterChip('Omega'), findsOneWidget);
      expect(filterChip('Rolex'), findsOneWidget);
    });

    testWidgets('filters watches when make chip is selected', (tester) async {
      await pumpLoadedScreen(tester);

      await tester.tap(filterChip('Rolex'));
      await tester.pump();

      expect(find.text(AppStrings.watchCount(1)), findsOneWidget);
      expect(find.text('Submariner'), findsOneWidget);
      expect(find.text('Speedmaster'), findsNothing);
    });

    testWidgets('shows empty state when search has no matches', (tester) async {
      final viewModel = await pumpLoadedScreen(tester);

      viewModel.setSearchInput('nonexistent-brand');
      await tester.pump();
      await tester.pump(
        Duration(milliseconds: AppConstants.searchDebounceMs + 50),
      );

      expect(find.text(AppStrings.emptySearchResults), findsOneWidget);
    });

    testWidgets('toggles between grid and list view', (tester) async {
      await pumpLoadedScreen(tester);

      expect(find.byType(GridView), findsOneWidget);

      await tester.tap(find.byTooltip(AppStrings.listViewTooltip));
      await tester.pump();

      expect(find.byType(GridView), findsNothing);
      expect(find.byType(ListView), findsWidgets);

      await tester.tap(find.byTooltip(AppStrings.gridViewTooltip));
      await tester.pump();

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('opens detail screen when a watch is tapped', (tester) async {
      await pumpLoadedScreen(tester);

      await tester.tap(find.text('Submariner'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byType(WatchDetailScreen), findsOneWidget);
    });

    testWidgets('shows error state with retry button', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final viewModel = WatchListViewModel(
        GetWatches(FakeWatchRepository(testWatches, shouldFail: true)),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: WatchListScreen(viewModel: viewModel),
        ),
      );
      await tester.pump();
      await viewModel.loadWatches();
      await tester.pump();

      expect(find.text(AppStrings.loadWatchesError), findsOneWidget);
      expect(find.text(AppStrings.retry), findsOneWidget);
    });
  });
}
