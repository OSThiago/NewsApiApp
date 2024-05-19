//
//  NewsAPIServiceProtocol.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 19/05/24.
//

import Foundation

protocol NewsAPIServiceProtocol {
    func fetchTopHeadlinesNews(endPoint: Endpoint) async throws -> NewsModel
}
