//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import SwiftUI

struct WatchImageView: View {
    let url: URL
    
    @State private var image: UIImage?
    @State private var hasError = false
    
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if hasError {
                errorPlaceholder
            } else {
                ProgressView()
            }
        }
        .clipped()
        .task(id: url) {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        do {
            image = try await ImageCache.shared.image(for: url)
        } catch {
            guard !Task.isCancelled else {
                return
            }
            
            hasError = true
        }
    }
    
    private var errorPlaceholder: some View {
        Image(systemName: "photo")
            .font(.title2)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
