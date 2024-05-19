//
//  NetworkError.swift
//
//
//  Created by Thiago de Oliveira Sousa on 18/05/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case network(Error?)
}
