import 'package:all_chrono/core/constants/app_constants.dart';
import 'package:all_chrono/presentation/watches/views/watch_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_data.dart';

void main() {
  group('WatchDetailScreen', () {
    testWidgets('displays watch details', (tester) async {
      tester.view.physicalSize = const Size(800, 2400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: WatchDetailScreen(watch: testWatchRolex),
        ),
      );
      await tester.pump();

      expect(find.text('Rolex'), findsWidgets);
      expect(find.text('Submariner'), findsNWidgets(2));
      expect(find.text(r'$14,500'), findsWidgets);
      expect(find.text(AppStrings.detailMake), findsOneWidget);
      expect(find.text(AppStrings.detailModel), findsOneWidget);
      expect(find.text(AppStrings.detailPrice), findsOneWidget);
      expect(find.text(AppStrings.detailCurrency), findsOneWidget);
      expect(find.text(AppStrings.detailId), findsOneWidget);
      expect(find.text('w-1'), findsOneWidget);
    });

    testWidgets('open pushes detail route', (tester) async {
      tester.view.physicalSize = const Size(800, 2400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: FilledButton(
                  onPressed: () =>
                      WatchDetailScreen.open(context, testWatchRolex),
                  child: const Text('Open detail'),
                ),
              );
            },
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Open detail'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byType(WatchDetailScreen), findsOneWidget);
      expect(find.text('Submariner'), findsWidgets);
    });
  });
}
