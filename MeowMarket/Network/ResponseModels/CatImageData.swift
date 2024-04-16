//
//  CatImageData.swift
//  MeowMarket
//

import Foundation

// Data model for a cat from the API
struct CatImageData: Codable {
    let id: String
    let mimetype: String
    let size: Int
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case mimetype, size, tags
    }
}
