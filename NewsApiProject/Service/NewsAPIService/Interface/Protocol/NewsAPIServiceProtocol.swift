//
//  NewsAPIServiceProtocol.swift
//
//
//  Created by Thiago de Oliveira Sousa on 17/05/24.
//

import Foundation

@available(iOS 13.0.0, *)
protocol NewsAPIServiceProtocol {
    func fetchTopHeadlinesNews(endPoint: Endpoint) async throws -> NewsModel
}
