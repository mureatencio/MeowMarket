//
//  CatDetailsViewModel.swift
//  MeowMarket
//

import Foundation

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
    
    func generateUrl() {
        let base = "https://cataas.com/cat/\(cat.id)"
        let textSegment = text.isEmpty ? "" : "/says/\(text)"
        let query = "?fontSize=\(Int(fontSize))&fontColor=white\(isMonochrome ? "&filter=mono" : "")"
        imageUrl = URL(string: base + textSegment + query)
    }
}
