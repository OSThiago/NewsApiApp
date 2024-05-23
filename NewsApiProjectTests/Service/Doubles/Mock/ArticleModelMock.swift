//
//  ArticleModelMock.swift
//  NewsApiProjectTests
//
//  Created by Thiago de Oliveira Sousa on 23/05/24.
//

import Foundation

@testable import NewsApiProject

extension ArticleModel {
    static func getMockFull1() -> Self {
        return .init(source: SourceModel(id: "cnn",
                                         name: "CNN"),
                     author: "Katie Hunt",
                     title: "Scientists a step closer to unraveling mystery of sun’s magnetic field - CNN",
                     description: "The sun’s powerful magnetic field has long puzzled scientists. A new study suggests the source of its magnetic field is nearer the surface than first thought.",
                     url: "https://www.cnn.com/2024/05/22/world/sun-magnetic-field-scn/index.html",
                     urlToImage: "https://media.cnn.com/api/v1/images/stellar/prod/43968478382-bdf5304f05-o.jpg?c=16x9&q=w_800,c_fill",
                     publishedAt: "2024-05-22T20:35:00Z",
                     content: "Sign up for CNNs Wonder Theory science newsletter. Explore the universe with news on fascinating discoveries, scientific advancements and more.\r\nThe sun has a powerful magnetic field that creates sun… [+4768 chars]")
    }
    
    static func getMockFull2() -> Self {
        return .init(source: SourceModel(id: "cnn",
                                         name: "CNN"),
                     author: "Andy Rose, Eric Levenson",
                     title: "Uvalde families reach $2M settlement with city and say they are suing school district and 92 officers over shooting response - CNN",
                     description: "Nineteen families of the students and teachers killed or injured at Robb Elementary School in Uvalde, Texas, announced Wednesday they have settled a lawsuit with the city for $2 million and said they are suing 92 officers with Texas Department of Public Safet…",
                     url: "https://www.cnn.com/2024/05/22/us/uvalde-shooting-victims-lawsuit/index.html",
                     urlToImage: "https://media.cnn.com/api/v1/images/stellar/prod/ap24143653880037.jpg?c=16x9&q=w_800,c_fill",
                     publishedAt: "2024-05-22T20:25:00Z",
                     content: "Nineteen families of the students and teachers killed or injured at Robb Elementary School in Uvalde, Texas, announced Wednesday they have settled a lawsuit with the city for $2 million, and announce… [+7280 chars]")
    }
    
    static func getMockRemoved() -> Self {
        return .init(source: SourceModel(id: nil,
                                         name: "Removed"),
                     author: nil,
                     title: "Removed",
                     description: nil,
                     url: nil,
                     urlToImage: nil,
                     publishedAt: nil,
                     content: nil)
    }
    
    static func getMockWithoutImage() -> Self {
        return .init(source: SourceModel(id: nil,
                                         name: "Financial Times"),
                     author: nil,
                     title: "Biggest US retailers cut prices as inflation hits shoppers - Financial Times",
                     description: "Analysts see Target and Walmart setting a new tone for sector after years of increases",
                     url: "https://www.ft.com/content/e3b5c1a0-48ac-4922-970a-8b9ca7c2539e",
                     urlToImage: nil,
                     publishedAt: "2024-05-22T15:18:28Z",
                     content: nil)
    }
}
