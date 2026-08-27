import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/di/service_locator.dart';
import '../presentation/watches/view_model/watch_list_view_model.dart';
import '../presentation/watches/views/watch_list_screen.dart';

void main() {
  ServiceLocator.instance.init();
  runApp(const AllChronoApp());
}

class AllChronoApp extends StatelessWidget {
  const AllChronoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppConstants.seedColor),
        useMaterial3: true,
      ),
      home: WatchListScreen(
        viewModel: WatchListViewModel(ServiceLocator.instance.getWatches),
      ),
    );
  }
}
