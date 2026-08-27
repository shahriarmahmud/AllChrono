//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import Foundation

struct FetchWatchesUseCase: Sendable {
    private let repository: WatchRepositoryProtocol

    init(repository: WatchRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Watch] {
        try await repository.fetchWatches()
    }
}
