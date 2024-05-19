//
//  NewsAPIServiceFactory.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 19/05/24.
//

import Foundation

struct NewsAPIServiceFactory {
    static var shared = NewsAPIServiceFactory()
    
    public init() {}
    
    func newsAPIService() -> NewsAPIServiceProtocol {
        return NewsAPIServiceImplementation()
    }
}
