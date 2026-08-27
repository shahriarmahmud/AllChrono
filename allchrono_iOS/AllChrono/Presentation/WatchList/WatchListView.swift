//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import SwiftUI

struct WatchListView: View {
    @State private var viewModel: WatchListViewModel
    @FocusState private var isSearchFocused: Bool

    init(viewModel: WatchListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    private let gridColumns = Array(
        repeating: GridItem(.flexible(), spacing: AppConstants.Layout.gridSpacing),
        count: AppConstants.Layout.gridColumns
    )

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchSection

                contentSection
            }
            .navigationTitle(AppConstants.Strings.appTitle)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    layoutToggleButton
                }
            }
            .task {
                await viewModel.loadWatches()
            }
            .navigationDestination(for: Watch.self) { watch in
                WatchDetailView(watch: watch)
            }
        }
    }

    private var searchSection: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)

                TextField(AppConstants.Strings.searchPlaceholder, text: $viewModel.searchText)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused($isSearchFocused)
                    .onChange(of: isSearchFocused) { _, isFocused in
                        viewModel.onSearchFocusChanged(isFocused)
                    }

                if !viewModel.searchText.isEmpty {
                    Button {
                        viewModel.searchText = ""
                        viewModel.dismissSuggestions()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: AppConstants.Layout.cardCornerRadius)
                    .fill(Color(.secondarySystemBackground))
            )
            .padding(.horizontal)
            .padding(.vertical, 8)

            if viewModel.isShowingSuggestions {
                SearchSuggestionsView(suggestions: viewModel.suggestions) { suggestion in
                    viewModel.selectSuggestion(suggestion)
                    isSearchFocused = false
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                .transition(.opacity)
            }
        }
    }

    @ViewBuilder
    private var contentSection: some View {
        switch viewModel.viewState {
        case .loading:
            loadingView
        case .error(let message):
            errorView(message: message)
        case .empty:
            emptyView
        case .loaded:
            watchListing
        }
    }

    private var watchListing: some View {
        ScrollView {
            Group {
                if viewModel.layout == .grid {
                    LazyVGrid(columns: gridColumns, spacing: AppConstants.Layout.gridSpacing) {
                        watchLinks {
                            WatchGridItemView(watch: $0)
                        }
                    }
                } else {
                    LazyVStack(spacing: AppConstants.Layout.listSpacing) {
                        watchLinks {
                            WatchListItemView(watch: $0)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .scrollDismissesKeyboard(.interactively)
    }

    private func watchLinks<Content: View>(
        @ViewBuilder content: @escaping (Watch) -> Content
    ) -> some View {
        ForEach(viewModel.filteredWatches) { watch in
            NavigationLink(value: watch) {
                content(watch)
            }
            .buttonStyle(.plain)
            .simultaneousGesture(TapGesture().onEnded {
                isSearchFocused = false
                viewModel.dismissSuggestions()
            })
        }
    }

    private var layoutToggleButton: some View {
        Button {
            viewModel.toggleLayout()
        } label: {
            Image(systemName: viewModel.layout == .grid ? "list.bullet" : "square.grid.2x2")
        }
        .accessibilityLabel(
            viewModel.layout == .grid
                ? AppConstants.Strings.switchToListView
                : AppConstants.Strings.switchToGridView
        )
    }

    private var loadingView: some View {
        VStack(spacing: 12) {
            ProgressView()
            Text(AppConstants.Strings.loadingMessage)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var emptyView: some View {
        ContentUnavailableView(
            AppConstants.Strings.noResultsTitle,
            systemImage: "magnifyingglass",
            description: Text(AppConstants.Strings.noResultsMessage)
        )
    }

    private func errorView(message: String) -> some View {
        ContentUnavailableView {
            Label(AppConstants.Strings.errorTitle, systemImage: "exclamationmark.triangle")
        } description: {
            Text(message)
        } actions: {
            Button(AppConstants.Strings.retry) {
                Task {
                    await viewModel.loadWatches()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    WatchListView(viewModel: AppComposition.makeWatchListViewModel())
}
