//
//  EndpointCase.swift
//  
//
//  Created by Thiago de Oliveira Sousa on 18/05/24.
//

import Foundation

enum EndpointCase: Endpoint {
    case fetchNews

    var baseURL: String {
        return APIConfig.baseURL
    }

    var httpMethod: String {
        return "GET"
    }

    var path: String {
        return "/v2/top-headlines?country=us"
    }

    var query: String? {
        return nil
    }

    var key: String { 
        return Authentication.key
    }
}
