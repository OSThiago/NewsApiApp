//
//  DetailNewsViewController.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 21/05/24.
//

import UIKit
import SafariServices

final class DetailNewsViewController: UIViewController {
    // MARK: - Properties
    private var viewModel: DetailNewsViewProtocol
    private var articleModel: ArticleModel?
    
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
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: "newspaper")
        imageView.tintColor = .black
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let articleTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.text = "Error"
        return label
    }()
    
    private let articleAuthor: UILabel = {
        let label = UILabel()
        label.textColor = .label.withAlphaComponent(0.7)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.text = "Error"
        return label
    }()
    
    private let articlePublishedDate: UILabel = {
        let label = UILabel()
        label.textColor = .label.withAlphaComponent(0.7)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "Error"
        return label
        
        // TODO: - Format date
    }()
    
    private let articleDescription: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .italicSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.text = "Error"
        return label
    }()
    
    private let articleContent: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.text = "Error"
        return label
    }()
    
    private let divider: UIView = {
        let diver = UIView()
        diver.backgroundColor = .gray.withAlphaComponent(0.2)
        return diver
    }()
    
    private let sourceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open News Source", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
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
        
        sourceButton.addTarget(self, action:#selector(self.openSourceAction), for: .touchUpInside)
    }
    
    func setupWith(_ article: ArticleModel) {
        self.articleModel = article
        self.articleTitle.text = article.title
        self.articleAuthor.text =  "By \(article.author ?? "unnamed")"
        self.articleDescription.text = article.description
        self.articleContent.text = article.content
        
        if let publishedAt = article.publishedAt {
            self.articlePublishedDate.text = "Published " + viewModel.formattedDate(dateString: publishedAt)
        }
        
        if let imageURL = article.urlToImage {
            self.articleImage.loadImage(urlString: imageURL,
                                        placeholderImage: nil,
                                        errorImage: nil)
        }
    }
    
    @objc func openSourceAction() {
        guard let articleURL = URL(string: articleModel?.url ?? "") else { return }
        let safariViewController = SFSafariViewController(url: articleURL)
        present(safariViewController, animated: true, completion: nil)
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
        self.contentView.addSubview(articleDescription)
        self.contentView.addSubview(articleContent)
        self.contentView.addSubview(divider)
        self.contentView.addSubview(sourceButton)
    }
    
    private func addConstraints() {
        setScrollViewConstraints()
        setContentViewConstraints()
        setArticleImageConstraints()
        setArticleTitleConstraints()
        setArticlePushedDateConstraints()
        setArticleAuthorConstraints()
        setArticleDescriptionConstraints()
        setArticleContentConstraints()
        setDividerViewConstraints()
        setSourceButtonConstraints()
    }
    
    // MARK: - Scroll View
    private func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    // MARK: - Content View
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
    
    // MARK: - Article Image
    private func setArticleImageConstraints() {
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleImage.topAnchor.constraint(equalTo: self.articlePublishedDate.bottomAnchor, constant: 16),
            articleImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            articleImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            articleImage.heightAnchor.constraint(equalTo: self.articleImage.widthAnchor, multiplier: 9/16)
        ])
    }
    
    // MARK: - Article Title
    private func setArticleTitleConstraints() {
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            articleTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Article Published Date
    private func setArticlePushedDateConstraints() {
        articlePublishedDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articlePublishedDate.topAnchor.constraint(equalTo: self.articleAuthor.bottomAnchor, constant: 4),
            articlePublishedDate.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        ])
    }
    
    // MARK: - Article Author
    private func setArticleAuthorConstraints() {
        articleAuthor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleAuthor.topAnchor.constraint(equalTo: self.articleTitle.bottomAnchor, constant: 24),
            articleAuthor.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            articleAuthor.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Article Description
    private func setArticleDescriptionConstraints() {
        articleDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleDescription.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 16),
            articleDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            articleDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Article Content
    private func setArticleContentConstraints() {
        articleContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleContent.topAnchor.constraint(equalTo: articleDescription.bottomAnchor, constant: 24),
            articleContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            articleContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Divider
    private func setDividerViewConstraints() {
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: articleDescription.bottomAnchor, constant: 8),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    // MARK: - Float button
    private func setSourceButtonConstraints() {
        sourceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sourceButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -24),
            sourceButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            sourceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            sourceButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
