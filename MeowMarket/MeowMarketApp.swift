//
//  MeowMarketApp.swift
//  MeowMarket
//

import SwiftUI
import SwiftData

// Default app loads cat image list view
struct MeowMarketApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CatImagesView()
            }
        }
    }
}
