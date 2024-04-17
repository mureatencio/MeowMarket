//
//  CatsRequest.swift
//  MeowMarket
//

import Foundation

protocol CatImagesRequest {
    var apiRequest: APIRequest { get set }

    // Fetches cat images from the API with configurable limit and skip values.
    //
    // - Parameters:
    //   - limit: The maximum number of cat images to return.
    //   - skip: The number of cat images to skip.
    // - Returns: An array of cat images data.
    //
    func fetchCatImages(limit: Int, skip: Int) async throws -> [Cat]
}

// CATaaS api urls description
struct CatsAPI {
    static let baseUrl = "https://cataas.com"
    static let baseApiUrl = "https://cataas.com/api"
    static let pageSize = 20
}

// Default cats request implementation
struct DefaultCatImagesRequest: CatImagesRequest {
    var apiRequest: APIRequest = DefaultAPIRequest()

    func fetchCatImages(limit: Int, skip: Int) async throws -> [Cat] {
        let urlString = "\(CatsAPI.baseApiUrl)/cats?limit=\(limit)&skip=\(skip)"
        let data: [Cat] = try await apiRequest.request(urlString: urlString)
        return data
    }
}
