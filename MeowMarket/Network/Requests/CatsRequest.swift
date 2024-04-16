//
//  CatsRequest.swift
//  MeowMarket
//

import Foundation

protocol CatImagesRequest {
    var apiRequest: APIRequest { get set }

    /// Fetches cat images from the API with configurable limit and skip values.
    ///
    /// - Parameters:
    ///   - limit: The maximum number of cat images to return.
    ///   - skip: The number of cat images to skip.
    /// - Returns: An array of cat images data.
    ///
    func fetchCatImages(limit: Int, skip: Int) async throws -> [Cat]
}

struct DefaultCatImagesRequest: CatImagesRequest {
    var apiRequest: APIRequest = DefaultAPIRequest()

    func fetchCatImages(limit: Int, skip: Int) async throws -> [Cat] {
        let urlString = "https://cataas.com/api/cats?limit=\(limit)&skip=\(skip)"
        let data: [Cat] = try await apiRequest.request(urlString: urlString)
        return data
    }
}
