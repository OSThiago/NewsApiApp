//
//  File.swift
//  
//
//  Created by Thiago de Oliveira Sousa on 17/05/24.
//

import Foundation

@available(iOS 13.0.0, *)
public struct NewsAPIServiceFactory {
    static public var shared = NewsAPIServiceFactory()
    
    public init() {}
    
    func newsAPIService() -> NewsAPIServiceProtocol {
        return NewsAPIServiceImplementation()
    }
}
