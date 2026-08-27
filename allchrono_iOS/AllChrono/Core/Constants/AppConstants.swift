//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//


import CoreGraphics
import Foundation

enum AppConstants {
    enum Strings {
        static let appTitle = "AllChrono"
        static let searchPlaceholder = "Search by make or model"
        static let noResultsTitle = "No Watches Found"
        static let noResultsMessage = "Try adjusting your search terms."
        static let loadingMessage = "Loading watches..."
        static let errorTitle = "Something Went Wrong"
        static let retry = "Retry"
        static let watchDetails = "Watch Details"
        static let make = "Make"
        static let model = "Model"
        static let price = "Price"
        static let currency = "Currency"
        static let id = "ID"
        static let switchToListView = "Switch to list view"
        static let switchToGridView = "Switch to grid view"
    }

    enum Layout {
        static let gridColumns = 2
        static let gridSpacing: CGFloat = 16
        static let listSpacing: CGFloat = 12
        static let imageCornerRadius: CGFloat = 12
        static let cardCornerRadius: CGFloat = 16
    }

    enum Search {
        static let debounceMilliseconds = 300
        static let maxSuggestions = 8
    }
}
