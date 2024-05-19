//
//  ViewController.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 19/05/24.
//

import UIKit

class ViewController: UIViewController {

    private let newsService: NewsAPIServiceProtocol

    init(newsService: NewsAPIServiceProtocol) {
        self.newsService = newsService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .orange
        
        Task {
            do {
                let news = try await newsService.fetchTopHeadlinesNews(endPoint: EndpointCase.fetchNews)
                print(news)
            } catch {
                print(error)
            }
        }
    }
}

