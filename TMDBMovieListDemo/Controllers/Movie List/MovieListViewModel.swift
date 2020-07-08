//
//  MovieListViewModel.swift
//  TMDBMovieListDemo
//
//  Created by Aarsh Parekh on 09/07/20.
//  Copyright © 2020 Aarsh. All rights reserved.
//

import UIKit

class MovieListViewModel {
    
    var movieListArray: [MovieResult]
    var pageNumber: Int
    var totalPageCount: Int = 0
    
    init() {
        pageNumber = 0
        movieListArray = [MovieResult]()
        getMovieList(withPageNumber: String(pageNumber + 1))
    }
    
    deinit {
    }
    
    func getMovieList(withPageNumber page: String) {
        MovieListHandler.fetchMovieList(withPageNumber: page, success: { [weak self] movieList in
            guard let self = self else { return }
            self.pageNumber = movieList.page
            self.totalPageCount = movieList.totalPages
            self.movieListArray.removeAll()
            self.movieListArray = movieList.results
        }) { errorString in
            
        }
    }
}
