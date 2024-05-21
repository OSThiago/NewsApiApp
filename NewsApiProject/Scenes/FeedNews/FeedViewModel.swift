//
//  FeedViewModel.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 19/05/24.
//

import Foundation

protocol FeedViewModelProtocol {
    var articles: [ArticlesModel] { get set }
    func fetchArticles() async throws
    func filterRemovedArticles(articles: [ArticlesModel]) -> [ArticlesModel]
}

protocol FeedViewModelDelegate: AnyObject {
    func reload()
}

final class FeedViewModel: FeedViewModelProtocol {

    private let newsService: NewsAPIServiceProtocol
    private weak var delegate: FeedViewModelDelegate?

    var articles: [ArticlesModel] = []

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

    func filterRemovedArticles(articles: [ArticlesModel]) -> [ArticlesModel] {
        return articles.filter { article in
            guard let title = article.title else { return false}
            return !title.contains("Removed")
        }
    }
}
