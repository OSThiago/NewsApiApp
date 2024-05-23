//
//  FeedViewModel.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 19/05/24.
//

import Foundation

protocol FeedViewModelProtocol {
    var articles: [ArticleModel] { get set }
    func fetchArticles() async throws
    func filterRemovedArticles(articles: [ArticleModel]) -> [ArticleModel]
}

protocol FeedViewModelDelegate: AnyObject {
    func reload()
}

final class FeedViewModel: FeedViewModelProtocol {

    private let newsService: NewsAPIServiceProtocol
    private weak var delegate: FeedViewModelDelegate?

    var articles: [ArticleModel] = []

    init(newsService: NewsAPIServiceProtocol,
         feedViewModelDelegate: FeedViewModelDelegate
    ) {
        self.newsService = newsService
        self.delegate = feedViewModelDelegate
    }

    func fetchArticles() async throws {
        do {
            let news = try await newsService.fetchTopHeadlinesNews(endPoint: EndpointCase.fetchNews)
            let filtered = filterRemovedArticles(articles: news.articles)
            self.articles = filtered
            self.delegate?.reload()
        } catch {
            print(error)
        }
    }

    func filterRemovedArticles(articles: [ArticleModel]) -> [ArticleModel] {
        return articles.filter { article in
            guard let title = article.title else { return false}
            return !title.contains("Removed")
        }
    }
}
