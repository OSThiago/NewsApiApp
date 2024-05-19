//
//  Endpoint.swift
//  
//
//  Created by Thiago de Oliveira Sousa on 18/05/24.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var httpMethod: String { get }
    var path: String { get }
    var query: String? { get }
    var key: String { get }
}

extension Endpoint {
    var url: String {
        var url = baseURL + path

        if let query {
            url.append(query)
        }

        url.append("&apiKey=\(key)")

        return url
    }
}
