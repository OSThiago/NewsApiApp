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
        guard let fileLocation = Bundle.main.url(forResource: "NewsMock", withExtension: "json") else { return NewsModel(status: "", totalResults: 0, articles: []) }
        do {
            let data = try Data(contentsOf: fileLocation)
            let decoder = JSONDecoder()
            return try decoder.decode(NewsModel.self, from: data)
        } catch {
            print("Error to decode json mock File")
        }
        return NewsModel(status: "", totalResults: 0, articles: [])
    }
}
