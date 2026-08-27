//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import Foundation

struct WatchRepository: WatchRepositoryProtocol {
    private let dataSource: LocalWatchDataSourceProtocol

    init(dataSource: LocalWatchDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func fetchWatches() async throws -> [Watch] {
        let dtos = try await dataSource.loadWatches()
        return try dtos.map { try $0.toDomain() }
    }
}
