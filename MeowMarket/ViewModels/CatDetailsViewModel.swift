//
//  CatDetailsViewModel.swift
//  MeowMarket
//

import Foundation

// Cat details view model.
// Implements new Observable protocol object that unifies state and stateObject
@Observable class CatDetailsViewModel {
    var text: String = ""
    var isMonochrome: Bool = false
    var imageUrl: URL?
    var fontSize: Double = 100
    
    var cat: Cat
    
    init(cat: Cat) {
        self.cat = cat
        DispatchQueue.main.async {
            self.generateUrl()
        }
    }
    
    // Generates the URL for the cat image with the specified text and settings.
    // Finally updates the binded imageUrl property to propagate changes to the view.
    func generateUrl() {
        let base = "\(CatsAPI.baseUrl)/cat/\(cat.id)"
        let textSegment = text.isEmpty ? "" : "/says/\(text)"
        let query = "?fontSize=\(Int(fontSize))&fontColor=white\(isMonochrome ? "&filter=mono" : "")"
        imageUrl = URL(string: base + textSegment + query)
    }
}
