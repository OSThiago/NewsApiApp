//
//  NewsModel.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 19/05/24.
//

import Foundation

public struct NewsModel: Decodable {
    public let status: String
    public let totalResults: Int
    public let articles: [ArticleModel]
}

public struct ArticleModel: Decodable {
    public let source: SourceModel
    public let author: String?
    public let title: String?
    public let description: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?
}

public struct SourceModel: Decodable {
    public let id: String?
    public let name: String?
}
