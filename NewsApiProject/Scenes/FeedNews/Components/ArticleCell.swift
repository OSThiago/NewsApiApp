//
//  FeedCell.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 19/05/24.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    static let identifier = "ArticleCell"
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        gradientLayer.frame = articleImage.bounds
        articleImage.layer.addSublayer(gradientLayer)
    }
    
    // MARK: - Configuration
    
    func setupWith(_ article: ArticleModel) {
        self.title.text = article.title
        self.articleDescription.text = article.description
        
        if let author = article.author {
            self.author.text = "Author: " + author
        }
        
        if let url = URL(string: article.urlToImage ?? "") {
            self.articleImage.load(url: url)
        }
    }
    
    // MARK: - Components
    private let articleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .black
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.text = "Error"
        return label
    }()
    
    private let author: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 1
        label.text = "Author unnamed"
        return label
    }()
    
    private let articleDescription: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.text = "Error"
        return label
    }()
    
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()

        layer.colors = [UIColor.black.withAlphaComponent(3.0).cgColor,
                        UIColor.black.withAlphaComponent(0.2).cgColor]

        layer.startPoint = CGPoint(x: 0, y: 1)
        layer.endPoint = CGPoint(x: 0, y: 0.5)
        
        return layer
    }()
}

// MARK: - Setup UI Components
extension ArticleCell {
    private func setupView() {
        addViews()
        addConstraints()
    }
    
    private func addViews() {
        self.addSubview(articleImage)
        self.addSubview(title)
        self.addSubview(author)
        self.addSubview(articleDescription)
    }
    
    private func addConstraints() {
        articleImageConstraints()
        titleConstraints()
        authorConstraints()
        descriptionConstraints()
    }
    
    private func articleImageConstraints() {
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            articleImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            articleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            articleImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/16)
        ])
    }
    
    private func titleConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.articleImage.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: self.articleImage.trailingAnchor, constant: -8),
            title.bottomAnchor.constraint(equalTo: self.articleImage.bottomAnchor, constant: -8),
        ])
    }
    
    private func authorConstraints() {
        author.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            author.topAnchor.constraint(equalTo: self.articleImage.bottomAnchor, constant: 6),
            author.leadingAnchor.constraint(equalTo: self.title.leadingAnchor),
            author.trailingAnchor.constraint(equalTo: self.title.trailingAnchor)
        ])
    }
    
    private func descriptionConstraints() {
        articleDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleDescription.topAnchor.constraint(equalTo: self.author.bottomAnchor, constant: 4),
            articleDescription.leadingAnchor.constraint(equalTo: self.author.leadingAnchor),
            articleDescription.trailingAnchor.constraint(equalTo: self.title.trailingAnchor),
        ])
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
