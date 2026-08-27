//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import Foundation

protocol WatchRepositoryProtocol: Sendable {
    func fetchWatches() async throws -> [Watch]
}
