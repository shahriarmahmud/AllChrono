//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//

import Foundation

protocol LocalWatchDataSourceProtocol: Sendable {
    func loadWatches() async throws -> [WatchDTO]
}

struct LocalWatchDataSource: LocalWatchDataSourceProtocol {
    private enum Resource {
        static let fileName = "watches"
        static let fileExtension = "json"
        static let subdirectory = "lib"
    }

    private let bundle: Bundle
    private let decoder: JSONDecoder

    init(bundle: Bundle = .main, decoder: JSONDecoder = JSONDecoder()) {
        self.bundle = bundle
        self.decoder = decoder
    }

    func loadWatches() async throws -> [WatchDTO] {
        let url = try resolveWatchesURL()
        let data = try Data(contentsOf: url)

        do {
            return try decoder.decode([WatchDTO].self, from: data)
        } catch {
            throw WatchDataError.decodingFailed
        }
    }

    private func resolveWatchesURL() throws -> URL {
        if let url = bundle.url(
            forResource: Resource.fileName,
            withExtension: Resource.fileExtension,
            subdirectory: Resource.subdirectory
        ) {
            return url
        }

        if let url = bundle.url(
            forResource: Resource.fileName,
            withExtension: Resource.fileExtension
        ) {
            return url
        }

        throw WatchDataError.fileNotFound
    }
}
