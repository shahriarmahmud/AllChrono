//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import SwiftUI

struct WatchGridItemView: View {
    let watch: Watch

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            WatchImageView(url: watch.imageURL)
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: AppConstants.Layout.imageCornerRadius))

            Text(watch.make)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)

            Text(watch.model)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            Text(watch.formattedPrice)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.tint)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: AppConstants.Layout.cardCornerRadius)
                .fill(Color(.secondarySystemBackground))
        )
    }
}
