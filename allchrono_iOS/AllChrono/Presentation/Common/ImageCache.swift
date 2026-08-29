//
//  ImageCache.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 30/8/26.
//

import SwiftUI

actor ImageCache {

    static let shared = ImageCache()

    private let cache = NSCache<NSURL, UIImage>()

    func image(for url: URL) async throws -> UIImage {

        if let cached = cache.object(forKey: url as NSURL) {
            return cached
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }

        cache.setObject(image, forKey: url as NSURL)

        return image
    }
}
