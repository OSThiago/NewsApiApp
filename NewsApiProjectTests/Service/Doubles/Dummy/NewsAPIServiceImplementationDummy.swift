//
//  NewsAPIServiceImplementationDummy.swift
//  NewsApiProjectTests
//
//  Created by Thiago de Oliveira Sousa on 23/05/24.
//

import Foundation

@testable import NewsApiProject

final class NewsAPIServiceImplementationDummy: NewsAPIServiceProtocol {
    func fetchTopHeadlinesNews(endPoint: any NewsApiProject.Endpoint) async throws -> NewsApiProject.NewsModel {
        return NewsModel.getDummy()
    }
}
