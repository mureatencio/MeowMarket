//
//  CatImagesState.swift
//  MeowMarket
//

import Foundation

// Object that manages the cat images state.
@Observable final class CatImagesState {
    // Whether or not there was an error fetching cat images.
    var errorFetching: Bool

    // Whether or not the cat images data is loading from the API.
    var fetchingData: Bool

    // The API to fetch cat images from.
    var catImagesRequest: CatImagesRequest

    // Initializer for the observable object managing cat images.
    //
    // - Parameters:
    //  - errorFetching: Whether or not there was an error fetching cat images.
    //  - fetchingData: Whether or not the cat images data is loading from the API.
    //  - catImagesRequest: The API to fetch cat images from.
    //
    init(
        errorFetching: Bool = false,
        fetchingData: Bool = false,
        catImagesRequest: CatImagesRequest = DefaultCatImagesRequest()
    ) {
        self.errorFetching = errorFetching
        self.fetchingData = fetchingData
        self.catImagesRequest = catImagesRequest
    }
}
