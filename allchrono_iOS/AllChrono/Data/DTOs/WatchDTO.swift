//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import Foundation

struct WatchDTO: Decodable, Sendable {
    let id: String
    let make: String
    let model: String
    let price: Int
    let currency: String
    let imageUrl: String

    func toDomain() throws -> Watch {
        guard let url = URL(string: imageUrl) else {
            throw WatchDataError.invalidImageURL(id: id)
        }

        return Watch(
            id: id,
            make: make,
            model: model,
            price: price,
            currency: currency,
            imageURL: url
        )
    }
}

enum WatchDataError: LocalizedError, Sendable {
    case fileNotFound
    case invalidImageURL(id: String)
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Could not find watches data file."
        case .invalidImageURL(let id):
            return "Invalid image URL for watch \(id)."
        case .decodingFailed:
            return "Failed to decode watches data."
        }
    }
}
