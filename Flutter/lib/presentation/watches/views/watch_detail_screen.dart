import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/price_formatter.dart';
import '../../../domain/entities/watch.dart';
import '../widgets/watch_image.dart';

class WatchDetailScreen extends StatelessWidget {
  const WatchDetailScreen({super.key, required this.watch});

  final Watch watch;

  static Future<void> open(BuildContext context, Watch watch) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => WatchDetailScreen(watch: watch),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(watch.make),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: WatchImage(imageUrl: watch.imageUrl),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  watch.make,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  watch.model,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  formatPrice(watch.price, watch.currency),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                _DetailRow(label: AppStrings.detailMake, value: watch.make),
                const SizedBox(height: 12),
                _DetailRow(label: AppStrings.detailModel, value: watch.model),
                const SizedBox(height: 12),
                _DetailRow(
                  label: AppStrings.detailPrice,
                  value: formatPrice(watch.price, watch.currency),
                ),
                const SizedBox(height: 12),
                _DetailRow(
                  label: AppStrings.detailCurrency,
                  value: watch.currency,
                ),
                const SizedBox(height: 12),
                _DetailRow(label: AppStrings.detailId, value: watch.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 88,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
