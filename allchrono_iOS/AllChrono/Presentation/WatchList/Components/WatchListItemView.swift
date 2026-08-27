//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import SwiftUI

struct WatchListItemView: View {
    let watch: Watch

    var body: some View {
        HStack(spacing: 12) {
            WatchImageView(url: watch.imageURL)
                .frame(width: 88, height: 88)
                .clipShape(RoundedRectangle(cornerRadius: AppConstants.Layout.imageCornerRadius))

            VStack(alignment: .leading, spacing: 4) {
                Text(watch.make)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(watch.model)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                Text(watch.formattedPrice)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.tint)
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: AppConstants.Layout.cardCornerRadius)
                .fill(Color(.secondarySystemBackground))
        )
    }
}
