//
//  MovieListHandler.swift
//  TMDBMovieListDemo
//
//  Created by Aarsh Parekh on 09/07/20.
//  Copyright © 2020 Aarsh. All rights reserved.
//

import Foundation

class MovieListHandler {
    
    static func fetchMovieList(withPageNumber page: String, success: @escaping (_ movieList: MovieListModel) -> Void, failure: @escaping (_ errString: String?) -> Void) {
        let movieRequest = MovieListRequester(pageNumber: page)
        NetworkManager.fetchApiData(withRequest: movieRequest) { result in
            switch result {
            case .success(let movieList):
                success(movieList)
            case .failure(let errString):
                failure(errString)
            }
        }
    }
    
}
