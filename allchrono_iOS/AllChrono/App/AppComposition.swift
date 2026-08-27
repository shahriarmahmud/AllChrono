import Foundation

enum AppComposition {
    static func makeWatchListViewModel() -> WatchListViewModel {
        WatchListViewModel(
            fetchWatchesUseCase: FetchWatchesUseCase(
                repository: WatchRepository(
                    dataSource: LocalWatchDataSource()
                )
            ),
            filterWatchesUseCase: FilterWatchesUseCase()
        )
    }
}
