//
//  CatsRequestTests.swift
//  MeowMarket
//

@testable import MeowMarket
import XCTest

final class CatsRequestTests: XCTestCase {
    /// Mocked api requestor.
    var apiMock: APIRequestMock!

    override func setUp () {
        apiMock = APIRequestMock()
    }

    /// Test fetching cats returns a list of properly mapped cat objects.
    func testFetchCats() async throws {
        apiMock.mockedDataFilename = "CatsData"

        let subject = DefaultCatImagesRequest(apiRequest: apiMock)

        let cats = try await subject.fetchCatImages(limit: 10, skip: 0)
        XCTAssertEqual(cats.count, 10)
    }
}
