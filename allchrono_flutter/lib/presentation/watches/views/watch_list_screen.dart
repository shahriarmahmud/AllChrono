import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../domain/entities/watch.dart';
import '../view_model/watch_list_view_model.dart';
import '../widgets/watch_grid_item.dart';
import '../widgets/watch_list_item.dart';
import '../widgets/watch_search_bar.dart';
import 'watch_detail_screen.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key, required this.viewModel});

  final WatchListViewModel viewModel;

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadWatches();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final viewModel = widget.viewModel;

        return Scaffold(
          appBar: AppBar(
            title: const Text(AppConstants.appName),
            actions: [
              IconButton(
                tooltip: viewModel.isGridView
                    ? AppStrings.listViewTooltip
                    : AppStrings.gridViewTooltip,
                onPressed: viewModel.toggleViewMode,
                icon: Icon(
                  viewModel.isGridView
                      ? Icons.view_list_rounded
                      : Icons.grid_view_rounded,
                ),
              ),
            ],
          ),
          body: switch (viewModel.status) {
            WatchListStatus.initial || WatchListStatus.loading =>
              const Center(child: CircularProgressIndicator()),
            WatchListStatus.failure => _ErrorState(
                message: viewModel.errorMessage ?? AppStrings.genericError,
                onRetry: viewModel.loadWatches,
              ),
            WatchListStatus.success => _WatchListBody(viewModel: viewModel),
          },
        );
      },
    );
  }
}

class _WatchListBody extends StatelessWidget {
  const _WatchListBody({required this.viewModel});

  final WatchListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final watches = viewModel.filteredWatches;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WatchSearchBar(
          searchInput: viewModel.searchInput,
          suggestions: viewModel.searchSuggestions,
          onChanged: viewModel.setSearchInput,
          onSuggestionSelected: viewModel.selectSearchSuggestion,
          onClear: viewModel.clearSearch,
        ),
        _MakeFilterBar(viewModel: viewModel),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            AppStrings.watchCount(watches.length),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        Expanded(
          child: watches.isEmpty
              ? const _EmptyState()
              : viewModel.isGridView
                  ? _WatchGrid(
                      watches: watches,
                      onWatchTap: (watch) =>
                          WatchDetailScreen.open(context, watch),
                    )
                  : _WatchList(
                      watches: watches,
                      onWatchTap: (watch) =>
                          WatchDetailScreen.open(context, watch),
                    ),
        ),
      ],
    );
  }
}

class _MakeFilterBar extends StatelessWidget {
  const _MakeFilterBar({required this.viewModel});

  final WatchListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text(AppStrings.filterAll),
              selected: viewModel.selectedMake == null,
              onSelected: (_) => viewModel.setSelectedMake(null),
            ),
          ),
          ...viewModel.makes.map(
            (make) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(make),
                selected: viewModel.selectedMake == make,
                onSelected: (_) => viewModel.setSelectedMake(make),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WatchGrid extends StatelessWidget {
  const _WatchGrid({required this.watches, required this.onWatchTap});

  final List<Watch> watches;
  final ValueChanged<Watch> onWatchTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: watches.length,
      itemBuilder: (context, index) {
        final watch = watches[index];
        return WatchGridItem(
          watch: watch,
          onTap: () => onWatchTap(watch),
        );
      },
    );
  }
}

class _WatchList extends StatelessWidget {
  const _WatchList({required this.watches, required this.onWatchTap});

  final List<Watch> watches;
  final ValueChanged<Watch> onWatchTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: watches.length,
      itemBuilder: (context, index) {
        final watch = watches[index];
        return WatchListItem(
          watch: watch,
          onTap: () => onWatchTap(watch),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.emptySearchResults,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }
}
