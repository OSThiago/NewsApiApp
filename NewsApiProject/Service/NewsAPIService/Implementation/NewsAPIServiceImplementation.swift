//
//  NewsAPIServiceImplementation.swift
//
//
//  Created by Thiago de Oliveira Sousa on 17/05/24.
//

import Foundation

@available(iOS 13.0.0, *)
public class NewsAPIServiceImplementation: NewsAPIServiceProtocol {
    func fetchTopHeadlinesNews(endPoint: any Endpoint) async throws -> NewsModel {
        let session = URLSession.shared

        guard let url = URL(string: endPoint.url) else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = endPoint.httpMethod

        let (data, response) = try await session.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(NewsModel.self, from: data)
        } catch {
            throw NetworkError.network(error)
        }
    }
}
