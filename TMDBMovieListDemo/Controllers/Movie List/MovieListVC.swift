//
//  MovieListVC.swift
//  TMDBMovieListDemo
//
//  Created by Aarsh Parekh on 09/07/20.
//  Copyright © 2020 Aarsh. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController {

    var viewModel: MovieListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieListViewModel()
    }

}
