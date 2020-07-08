//
//  NetworkRouter.swift
//  TMDBMovieListDemo
//
//  Created by Aarsh Parekh on 08/07/20.
//  Copyright © 2020 Aarsh. All rights reserved.
//

import UIKit

class NetworkRouter {
    
    static let movieBaseURL = "https://api.themoviedb.org/"
    static let imageBaseURL = ""
    enum APIEndPoints: String {
        case movieList = "3/movie/popular"
    }
    
    
}
