import Foundation
@testable import MeowMarket

struct CatImagesRequestMock: CatImagesRequest {
    var apiRequest: APIRequest = APIRequestMock()
    var mockedDataFilename: String?
    var error: APIRequestError?

    func fetchCatImages(limit: Int, skip: Int) async throws -> [Cat] {
        guard let mockRequest = apiRequest as? APIRequestMock else { return [] }

        mockRequest.error = error
        mockRequest.mockedDataFilename = mockedDataFilename 

        let data: [Cat] = try await mockRequest.request(urlString: "")
        return data
    }
}
