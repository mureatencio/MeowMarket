//
//  CatImagesViewModel.swift
//  MeowMarket
//

import SwiftUI
import SwiftData

@Observable class CatImagesViewModel {
    var state = CatImagesState()
    
    private let dataSource: CatsDataSource
    private var isLoading = false
    private var page = 0
    private let itemsPerPage = 20
    private var reachedEnd = false
    
    /// The data that is queried from SwiftData and used to populate the views.
    var cats: [Cat] = []

    init(state: CatImagesState = CatImagesState(), dataSource: CatsDataSource = CatsDataSource.shared) {
        self.state = state
        self.dataSource = dataSource
        DispatchQueue.main.async {
            self.loadMoreContentIfNeeded(currentItem: nil)
        }
    }
    
    
    func loadMoreContentIfNeeded(currentItem cat: Cat?) {
        guard !isLoading, !reachedEnd else { return }
        if let cat = cat, cat.id != cats.last?.id { return }

        isLoading = true
        Task {
            await fetchCatImages()
        }
    }
    
    // MARK: - Private Functions

    /// Fetches cat images from the API and stores them in SwiftData.
    ///
    @MainActor
    func fetchCatImages() async {
        state.fetchingData = true
        do {
            let newCats = try await state.catImagesRequest.fetchCatImages(limit: itemsPerPage, skip: page*itemsPerPage)
            if newCats.isEmpty {
                self.reachedEnd = true
            }
            cats.append(contentsOf: newCats)
            page += 1
        } catch {
            print(error)
            state.errorFetching = true
        }
        state.fetchingData = false
        isLoading = false
    }
}
