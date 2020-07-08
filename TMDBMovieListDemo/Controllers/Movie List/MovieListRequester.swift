//
//  MovieListRequester.swift
//  TMDBMovieListDemo
//
//  Created by Aarsh Parekh on 09/07/20.
//  Copyright © 2020 Aarsh. All rights reserved.
//

import Foundation

class MovieListRequester: NetworkRequestable {
    
    typealias ResultType = MovieListModel
    
    var endpoint: String {
        return NetworkRouter.APIEndPoints.movieList.rawValue
    }
    
    var method: NetworkManager.HTTPMethod {
        return .get
    }
    
    var query: NetworkManager.BodyType {
        return .queryParameters
    }
    
    var parameters: [String : Any]? {
        return [
            "api_key" : "2cf28df74f7463ce7ef6ffd4dca51713",
            "page":self.pageNumber]
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var baseUrl: URL? {
        return URL(string: NetworkRouter.movieBaseURL)
    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
    
    
    private var pageNumber :String
    
    init(pageNumber:String) {
        self.pageNumber = pageNumber
    }
}
