//
//  Cat.swift
//  MeowMarket
//

import Foundation
import SwiftData

@Model
final class Cat: Identifiable, Decodable {
    @Attribute(.unique) let id: String
    let mimetype: String
    let size: Int
    let tags: [String]
    
    init(data: CatImageData) {
        self.id = data.id
        self.mimetype = data.mimetype
        self.size = data.size
        self.tags = data.tags
    }

    // Custom init from Decoder to handle the decoding process
    convenience init(from decoder: Decoder) throws {
        // Define the keys used in your JSON
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case mimetype, size, tags
        }
        
        // Create a container using the defined keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode each property
        let id = try container.decode(String.self, forKey: .id)
        let mimetype = try container.decode(String.self, forKey: .mimetype)
        let size = try container.decode(Int.self, forKey: .size)
        let tags = try container.decode([String].self, forKey: .tags)
        
        // Initialize the Cat instance using the decoded values
        self.init(data: CatImageData(id: id, mimetype: mimetype, size: size, tags: tags))
    }
}
