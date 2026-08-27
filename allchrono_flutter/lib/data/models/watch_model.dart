import '../../core/constants/app_constants.dart';
import '../../domain/entities/watch.dart';

class WatchModel extends Watch {
  const WatchModel({
    required super.id,
    required super.make,
    required super.model,
    required super.price,
    required super.currency,
    required super.imageUrl,
  });

  factory WatchModel.fromJson(Map<String, dynamic> json) {
    return WatchModel(
      id: json[WatchJsonKeys.id] as String,
      make: json[WatchJsonKeys.make] as String,
      model: json[WatchJsonKeys.model] as String,
      price: json[WatchJsonKeys.price] as int,
      currency: json[WatchJsonKeys.currency] as String,
      imageUrl: json[WatchJsonKeys.imageUrl] as String,
    );
  }
}
