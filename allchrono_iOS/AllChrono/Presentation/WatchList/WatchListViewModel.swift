//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import Combine
import Foundation

enum WatchListLayout {
    case grid
    case list
}

enum WatchListViewState: Equatable {
    case loading
    case loaded
    case empty
    case error(String)
}

@MainActor
@Observable
final class WatchListViewModel {
    private(set) var filteredWatches: [Watch] = []
    private(set) var suggestions: [String] = []
    private(set) var viewState: WatchListViewState = .loading

    var searchText = "" {
        didSet {
            searchSubject.send(searchText)
        }
    }

    var layout: WatchListLayout = .grid
    var isShowingSuggestions = false

    private let fetchWatchesUseCase: FetchWatchesUseCase
    private let filterWatchesUseCase: FilterWatchesUseCase
    private let searchSubject = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var allWatches: [Watch] = []

    init(
        fetchWatchesUseCase: FetchWatchesUseCase,
        filterWatchesUseCase: FilterWatchesUseCase
    ) {
        self.fetchWatchesUseCase = fetchWatchesUseCase
        self.filterWatchesUseCase = filterWatchesUseCase
        bindSearch()
    }

    func loadWatches() async {
        viewState = .loading

        do {
            let loadedWatches = try await fetchWatchesUseCase.execute()
            allWatches = loadedWatches
            applyFilter(query: searchText)
            viewState = filteredWatches.isEmpty ? .empty : .loaded
        } catch {
            viewState = .error(error.localizedDescription)
        }
    }

    func toggleLayout() {
        layout = layout == .grid ? .list : .grid
    }

    func selectSuggestion(_ suggestion: String) {
        searchText = suggestion
        isShowingSuggestions = false
    }

    func dismissSuggestions() {
        isShowingSuggestions = false
    }

    func onSearchFocusChanged(_ isFocused: Bool) {
        isShowingSuggestions = isFocused && !suggestions.isEmpty
    }

    private func bindSearch() {
        searchSubject
            .debounce(
                for: .milliseconds(AppConstants.Search.debounceMilliseconds),
                scheduler: RunLoop.main
            )
            .removeDuplicates()
            .sink { [weak self] query in
                self?.applyFilter(query: query)
            }
            .store(in: &cancellables)
    }

    private func applyFilter(query: String) {
        filteredWatches = filterWatchesUseCase.execute(watches: allWatches, query: query)
        suggestions = filterWatchesUseCase.suggestions(
            from: allWatches,
            query: query,
            limit: AppConstants.Search.maxSuggestions
        )
        isShowingSuggestions = !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !suggestions.isEmpty

        switch viewState {
        case .loading, .error:
            break
        default:
            viewState = filteredWatches.isEmpty ? .empty : .loaded
        }
    }
}
