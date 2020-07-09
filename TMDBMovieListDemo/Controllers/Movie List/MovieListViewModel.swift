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
    var currentPage: Int
    var totalPageCount: Int
    var parentControllerReference: MovieListVC
    
    init(withParentReference parentController: MovieListVC) {
        currentPage = 0
        totalPageCount = 1
        movieListArray = [MovieResult]()
        parentControllerReference = parentController
    }
    
    deinit {
    }
    
    func getMovieList(withPageNumber page: String) {
        MovieListHandler.fetchMovieList(withPageNumber: page, success: { [weak self] movieList in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.currentPage = movieList.page
                self.totalPageCount = movieList.totalPages
                self.movieListArray.removeAll()
                self.movieListArray = movieList.results
                self.parentControllerReference.refreshTableView()
            }
        }) { [weak self] errorString in
            guard let self = self else { return }
            Alert.showNormalAlert(withTitle: nil, message: errorString ?? "Something went wrong. Please try again!", onController: self.parentControllerReference)
        }
    }
}
