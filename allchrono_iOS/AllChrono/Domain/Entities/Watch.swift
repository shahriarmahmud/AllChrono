//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import Foundation

struct Watch: Identifiable, Hashable, Sendable {
    let id: String
    let make: String
    let model: String
    let price: Int
    let currency: String
    let imageURL: URL

    var displayName: String {
        "\(make) \(model)"
    }

    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: price)) ?? "\(currency) \(price)"
    }

    func matches(query: String) -> Bool {
        let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !normalizedQuery.isEmpty else { return true }

        return make.lowercased().contains(normalizedQuery)
            || model.lowercased().contains(normalizedQuery)
            || displayName.lowercased().contains(normalizedQuery)
    }
}
