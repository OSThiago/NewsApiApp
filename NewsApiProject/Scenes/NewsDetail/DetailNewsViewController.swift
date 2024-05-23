//
//  DetailNewsViewController.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 21/05/24.
//

import UIKit

final class DetailNewsViewController: UIViewController {
    // MARK: - Properties
    private var viewModel: DetailNewsViewProtocol
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .systemBackground
        return contentView
    }()
    
    private let articleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .black
        return imageView
    }()
    
    private let articleTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.text = "Error"
        return label
    }()
    
    private let articleAuthor: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.text = "Error"
        return label
    }()
    
    private let articlePublishedDate: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "Error"
        return label
        
        // TODO: - Format date
    }()
    
    private let articleContent: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.text = "Error"
        return label
    }()
    
    // MARK: - Life Cycle
    
    init() {
        self.viewModel = DetailNewsViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupWith(_ article: ArticleModel) {
        
        self.articleTitle.text = article.title
        self.articleAuthor.text =  "Author: \(article.author ?? "unnamed")"
        
        if let publishedAt = article.publishedAt {
            self.articlePublishedDate.text = viewModel.formattedDate(dateString: publishedAt)
        }

        if let articleContent = article.content {
            self.articleContent.text = article.content
        } else {
            self.articleContent.text = article.description
        }
        
        if let url = URL(string: article.urlToImage ?? "") {
            articleImage.load(url: url)
        }
    }
}

// MARK: - Setup UI Components
extension DetailNewsViewController {
    private func setupView() {
        addViews()
        addConstraints()
    }
    
    private func addViews() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(articleImage)
        self.contentView.addSubview(articleTitle)
        self.contentView.addSubview(articlePublishedDate)
        self.contentView.addSubview(articleAuthor)
        self.contentView.addSubview(articleContent)
    }
    
    private func addConstraints() {
        setScrollViewConstraints()
        setContentViewConstraints()
        setArticleImageConstraints()
        setArticleTitleConstraints()
        setArticlePushedDateConstraints()
        setArticleAuthorConstraints()
        setArticleContentConstraints()
    }
    
    private func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func setContentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor),
        ])
    }
    
    private func setArticleImageConstraints() {
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            articleImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            articleImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            articleImage.heightAnchor.constraint(equalTo: self.articleImage.widthAnchor, multiplier: 9/16)
        ])
    }
    
    private func setArticleTitleConstraints() {
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 8),
            articleTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            articleTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
        ])
    }
    
    private func setArticlePushedDateConstraints() {
        articlePublishedDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articlePublishedDate.topAnchor.constraint(equalTo: self.articleTitle.bottomAnchor, constant: 8),
            articlePublishedDate.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
        ])
    }
    
    private func setArticleAuthorConstraints() {
        articleAuthor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleAuthor.topAnchor.constraint(equalTo: self.articleTitle.bottomAnchor, constant: 8),
            articleAuthor.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            articleAuthor.trailingAnchor.constraint(equalTo: self.articlePublishedDate.leadingAnchor, constant: -8)
        ])
    }
    
    private func setArticleContentConstraints() {
        articleContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleContent.topAnchor.constraint(equalTo: articleAuthor.bottomAnchor, constant: 8),
            articleContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            articleContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}
