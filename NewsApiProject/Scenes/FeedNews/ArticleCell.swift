//
//  FeedCell.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 19/05/24.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    static let identifier = "ArticleCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWith(_ article: ArticlesModel) {
        self.title.text = article.title
        
        if let url = URL(string: article.urlToImage ?? "") {
            self.articleImage.load(url: url)
        }
    }
    
    // MARK: - Components
    private let articleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .black
//        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
        label.text = "Error"
        return label
    }()
}

// MARK: - Setup
extension ArticleCell {
    private func setupView() {
        addViews()
        addConstraints()
    }
    
    private func addViews() {
        self.addSubview(articleImage)
        self.addSubview(title)
    }
    
    private func addConstraints() {
        articleImageConstraints()
        titleConstraints()
    }
    
    private func articleImageConstraints() {
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            articleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            articleImage.topAnchor.constraint(equalTo: self.topAnchor),
            articleImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            articleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            articleImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
//            articleImage.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 8),
        ])
    }
    
    private func titleConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.articleImage.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: self.articleImage.trailingAnchor, constant: -8),
            title.topAnchor.constraint(equalTo: self.articleImage.bottomAnchor, constant: 4),
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
