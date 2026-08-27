//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import SwiftUI

struct WatchDetailView: View {
    let watch: Watch

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                WatchImageView(url: watch.imageURL)
                    .frame(maxWidth: .infinity)
                    .frame(height: 320)
                    .clipShape(RoundedRectangle(cornerRadius: AppConstants.Layout.cardCornerRadius))

                VStack(alignment: .leading, spacing: 8) {
                    Text(watch.make)
                        .font(.title3)
                        .foregroundStyle(.secondary)

                    Text(watch.model)
                        .font(.title.bold())

                    Text(watch.formattedPrice)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.tint)
                }

                detailSection
            }
            .padding()
        }
        .navigationTitle(AppConstants.Strings.watchDetails)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var detailSection: some View {
        VStack(spacing: 0) {
            detailRow(title: AppConstants.Strings.id, value: watch.id)
            Divider()
            detailRow(title: AppConstants.Strings.make, value: watch.make)
            Divider()
            detailRow(title: AppConstants.Strings.model, value: watch.model)
            Divider()
            detailRow(title: AppConstants.Strings.price, value: watch.formattedPrice)
            Divider()
            detailRow(title: AppConstants.Strings.currency, value: watch.currency)
        }
        .background(
            RoundedRectangle(cornerRadius: AppConstants.Layout.cardCornerRadius)
                .fill(Color(.secondarySystemBackground))
        )
    }

    private func detailRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .font(.subheadline.weight(.medium))
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    NavigationStack {
        WatchDetailView(
            watch: Watch(
                id: "w-0001",
                make: "Rolex",
                model: "Submariner Date",
                price: 14500,
                currency: "USD",
                imageURL: URL(string: "https://picsum.photos/seed/allchrono-01/400/400")!
            )
        )
    }
}
