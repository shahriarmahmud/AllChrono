import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';

class WatchSearchBar extends StatefulWidget {
  const WatchSearchBar({
    super.key,
    required this.searchInput,
    required this.suggestions,
    required this.onChanged,
    required this.onSuggestionSelected,
    required this.onClear,
  });

  final String searchInput;
  final List<String> suggestions;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSuggestionSelected;
  final VoidCallback onClear;

  @override
  State<WatchSearchBar> createState() => _WatchSearchBarState();
}

class _WatchSearchBarState extends State<WatchSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.searchInput);
    _focusNode = FocusNode()..addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant WatchSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchInput != _controller.text) {
      _controller.text = widget.searchInput;
      _controller.selection = TextSelection.collapsed(
        offset: widget.searchInput.length,
      );
    }
  }

  void _handleFocusChange() {
    setState(() {
      _showSuggestions = _focusNode.hasFocus && widget.searchInput.isNotEmpty;
    });
  }

  void _handleChanged(String value) {
    setState(() {
      _showSuggestions = _focusNode.hasFocus && value.isNotEmpty;
    });
    widget.onChanged(value);
  }

  void _handleClear() {
    _controller.clear();
    setState(() => _showSuggestions = false);
    widget.onClear();
  }

  void _handleSuggestionTap(String suggestion) {
    _controller.text = suggestion;
    _controller.selection = TextSelection.collapsed(offset: suggestion.length);
    setState(() => _showSuggestions = false);
    _focusNode.unfocus();
    widget.onSuggestionSelected(suggestion);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showSuggestions =
        _showSuggestions && widget.suggestions.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchBar(
            controller: _controller,
            focusNode: _focusNode,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Icon(
                Icons.search,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            hintText: AppStrings.searchHint,
            textInputAction: TextInputAction.search,
            onChanged: _handleChanged,
            onSubmitted: widget.onSuggestionSelected,
            trailing: widget.searchInput.isEmpty
                ? null
                : [
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _handleClear,
                    ),
                  ],
          ),
          if (showSuggestions)
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              color: theme.colorScheme.surfaceContainerHighest,
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.suggestions.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: theme.colorScheme.outlineVariant,
                ),
                itemBuilder: (context, index) {
                  final suggestion = widget.suggestions[index];
                  return ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.search,
                      size: 20,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    title: Text(suggestion),
                    onTap: () => _handleSuggestionTap(suggestion),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
