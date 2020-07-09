//
//  NetworkRouter.swift
//  TMDBMovieListDemo
//
//  Created by Aarsh Parekh on 08/07/20.
//  Copyright © 2020 Aarsh. All rights reserved.
//

import UIKit

class NetworkRouter {
    
    static let movieBaseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/original/"
    enum APIEndPoints: String {
        case movieList = "/trending/movie/week"
    }
}
