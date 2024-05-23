//
//  NewsModelDummy.swift
//  NewsApiProjectTests
//
//  Created by Thiago de Oliveira Sousa on 23/05/24.
//

import Foundation

@testable import NewsApiProject

extension NewsModel {
    static func getDummy() -> NewsModel {
        return NewsModel(status: "ok",
                         totalResults: 1,
                         articles: [
                            ArticleModel(source: SourceModel(id: "",
                                                             name: ""),
                                         author: "",
                                         title: "",
                                         description: "",
                                         url: "",
                                         urlToImage: "",
                                         publishedAt: "",
                                         content: "")
                         ])
    }
}
