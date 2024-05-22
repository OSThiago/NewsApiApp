//
//  FeedViewController.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 19/05/24.
//

import UIKit

final class FeedViewController: UIViewController {
    // MARK: - Properties
    private let newsService: NewsAPIServiceProtocol
    private lazy var viewModel = FeedViewModel(newsService: newsService,
                                              feedViewModelDelegate: self)
    
    // MARK: - UI Components
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 300
        return tableView
    }()
    
    // MARK: - Life cycle
    init(newsService: NewsAPIServiceProtocol) {
        self.newsService = newsService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()

        Task {
            try await viewModel.fetchArticles()
        }
    }
    
    private func setupUI() {
        setupTitle(title: "News")
        setupTableView()
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        tableView.frame = view.bounds
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupTitle(title: String) {
        self.title = title
    }
}

extension FeedViewController: FeedViewModelDelegate {
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier,
                                                       for: indexPath) as? ArticleCell else {
            fatalError("Unebale to dequeue ArtcleCell in FeedViewController")
        }
        
        let article = self.viewModel.articles[indexPath.row]
        
        cell.setupWith(article)

        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return 300
//        return UITableView.automaticDimension
//    }
}

extension FeedViewController: UITableViewDelegate {
    
}


