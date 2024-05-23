//
//  FeedViewModelTest.swift
//  NewsApiProjectTests
//
//  Created by Thiago de Oliveira Sousa on 23/05/24.
//

import XCTest
@testable import NewsApiProject

final class FeedViewModelTest: XCTestCase {

    private var sut: FeedViewModelProtocol!
    private var newsAPIService: NewsAPIServiceProtocol!
    private var feedViewModelDelegate: FeedViewModelDelegate!
    
    override func setUpWithError() throws {
        self.newsAPIService = NewsAPIServiceImplementationDummy()
        self.feedViewModelDelegate = FeedViewModelDelegateDummy()
        self.sut = FeedViewModel(newsService: newsAPIService,
                                 feedViewModelDelegate: feedViewModelDelegate)
    }

    override func tearDownWithError() throws {
        self.feedViewModelDelegate = nil
        self.newsAPIService = nil
        self.sut = nil
    }
    
    func test_fetch_articles_success() async throws {
        // Given
        self.sut.articles = []
        
        // When
        try await sut.fetchArticles()
        
        // Then
        XCTAssertNotNil(self.sut.articles)
    }
    
    func test_filter_removed_articles_success() throws {
        // Given
        let articles = NewsModel.getMock().articles
        let filter = "Removed"
        
        // When
        let filtered = sut.filterRemovedArticles(articles: articles)
        
        // Then
        XCTAssertFalse(filtered.contains(where: { $0.title == filter}))
    }
    
    func test_filter_has_image_success() throws {
        // Given
        let articles = NewsModel.getMock().articles
        
        // When
        let filtered = sut.filterHasImage(articles: articles)
        
        // Then
        XCTAssertFalse(filtered.contains(where: { $0.urlToImage == nil }))
    }
}
