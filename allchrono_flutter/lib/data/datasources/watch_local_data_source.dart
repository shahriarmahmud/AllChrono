import 'dart:convert';

import 'package:flutter/services.dart';

import '../../core/constants/app_constants.dart';
import '../models/watch_model.dart';

abstract class WatchLocalDataSource {
  Future<List<WatchModel>> loadWatches();
}

class WatchLocalDataSourceImpl implements WatchLocalDataSource {
  @override
  Future<List<WatchModel>> loadWatches() async {
    final jsonString =
        await rootBundle.loadString(AppConstants.watchesAssetPath);
    final decoded = json.decode(jsonString) as List<dynamic>;

    return decoded
        .map((item) => WatchModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
