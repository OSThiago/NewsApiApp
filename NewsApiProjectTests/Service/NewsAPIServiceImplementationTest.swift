//
//  NewsAPIServiceImplementationTest.swift
//  NewsApiProjectTests
//
//  Created by Thiago de Oliveira Sousa on 19/05/24.
//

import XCTest
@testable import NewsApiProject

final class NewsAPIServiceImplementationTest : XCTestCase {

    private var sut: NewsAPIServiceProtocol!
    
    override func setUpWithError() throws {
        self.sut = NewsAPIServiceImplementation()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_fetch_top_headlies_news() async throws {
        // Given
        let endpoint = EndpointCase.fetchNews

        // When
        let news = try await sut.fetchTopHeadlinesNews(endPoint: endpoint)

        // Then
        XCTAssertNotNil(news)
    }
    
}
