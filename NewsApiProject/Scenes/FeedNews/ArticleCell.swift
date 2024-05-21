//
//  FeedCell.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 19/05/24.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    let identifier = "ArticleCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWith(_ news: ArticlesModel) {
        // TODO: - setup componets data
    }
}

extension ArticleCell {
    private func setupView() {
        addViews()
        addConstraints()
    }
    
    private func addViews() {
        // Add subviews
    }
    
    private func addConstraints() {
        // Add constraints
    }
}
