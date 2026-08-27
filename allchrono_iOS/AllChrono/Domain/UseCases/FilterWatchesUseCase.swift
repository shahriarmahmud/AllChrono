//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import Foundation

struct FilterWatchesUseCase: Sendable {
    func execute(watches: [Watch], query: String) -> [Watch] {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else { return watches }
        return watches.filter { $0.matches(query: trimmedQuery) }
    }

    func suggestions(from watches: [Watch], query: String, limit: Int) -> [String] {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !trimmedQuery.isEmpty else { return [] }

        var seen = Set<String>()
        var results: [String] = []

        for watch in watches where watch.matches(query: trimmedQuery) {
            let candidates = [watch.make, watch.model, watch.displayName]
            for candidate in candidates where candidate.lowercased().contains(trimmedQuery) {
                let key = candidate.lowercased()
                if seen.insert(key).inserted {
                    results.append(candidate)
                    if results.count >= limit { return results }
                }
            }
        }

        return results
    }
}
