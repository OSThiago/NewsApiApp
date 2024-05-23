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
    
    // MARK: - Life Cycle
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
        self.title = "News"
        setupTableView()
    }
    
    // MARK: - UI Components
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 300
        return tableView
    }()
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        tableView.frame = view.bounds
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

// MARK: - FeedViewModelDelegate
extension FeedViewController: FeedViewModelDelegate {
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableView DataSource
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell else {
            fatalError("Unebale to dequeue ArtcleCell in FeedViewController")
        }
        
        let article = self.viewModel.articles[indexPath.row]
        
        cell.setupWith(article)

        return cell
    }
}

// MARK: - UITableView Delegate
extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        let detailViewController = DetailNewsViewController()
        detailViewController.setupWith(viewModel.articles[indexPath.row])

        detailViewController.title = "Detail"
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}


