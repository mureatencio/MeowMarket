//
//  MeowMarketApp.swift
//  MeowMarket
//

import SwiftUI
import SwiftData

struct MeowMarketApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CatImagesView()
            }
        }
    }
}
