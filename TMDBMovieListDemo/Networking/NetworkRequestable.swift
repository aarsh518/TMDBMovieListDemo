//
//  NetworkRequestable.swift
//  TMDBMovieListDemo
//
//  Created by Aarsh Parekh on 09/07/20.
//  Copyright © 2020 Aarsh. All rights reserved.
//

import Foundation

protocol NetworkRequestable {
    associatedtype ResultType: Codable
    var endpoint: String { get }
    var method: NetworkManager.HTTPMethod { get }
    var query:  NetworkManager.BodyType { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var baseUrl: URL? { get }
    var timeout : TimeInterval { get }
    var cachePolicy : NSURLRequest.CachePolicy { get }
    
}
