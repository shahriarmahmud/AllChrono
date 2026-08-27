//
//  AllChronoApp.swift
//  AllChrono
//
//  Created by Shahriar Mahmud on 28/8/26.
//

import SwiftUI

@main
struct AllChronoApp: App {
    var body: some Scene {
        WindowGroup {
            WatchListView(viewModel: AppComposition.makeWatchListViewModel())
        }
    }
}
