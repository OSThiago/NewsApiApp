//
//  NewsModelMock.swift
//  NewsApiProjectTests
//
//  Created by Thiago de Oliveira Sousa on 23/05/24.
//

import Foundation

@testable import NewsApiProject

extension NewsModel {
    static func getMock() -> NewsModel {
        return NewsModel(status: "ok",
                         totalResults: 4,
                         articles: [
                            .getMockFull1(),
                            .getMockFull2(),
                            .getMockRemoved(),
                            .getMockWithoutImage()
                         ])
    }
}
