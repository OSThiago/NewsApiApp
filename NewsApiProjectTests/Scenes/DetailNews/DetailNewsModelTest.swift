//
//  DetailNewsModelTest.swift
//  NewsApiProjectTests
//
//  Created by Thiago de Oliveira Sousa on 23/05/24.
//

import XCTest

@testable import NewsApiProject

final class DetailNewsModelTest: XCTestCase {
    
    private var sut: DetailNewsViewProtocol!
    
    override func setUpWithError() throws {
        self.sut = DetailNewsViewModel()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_formatted_date_success() throws {
        // Given
        let date = "2024-05-22T20:35:00Z"
        let expectedDate = "5:35 PM, Wed May 22, 2024"

        // When
        let formattedData = sut.formattedDate(dateString: date)
        
        // Then
        XCTAssertEqual(formattedData, expectedDate)
    }
}
