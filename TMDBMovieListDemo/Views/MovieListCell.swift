//
//  MovieListCell.swift
//  TMDBMovieListDemo
//
//  Created by Aarsh Parekh on 09/07/20.
//  Copyright © 2020 Aarsh. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {

    static let identifier = #function
    
    @IBOutlet weak var moviePosterImageView: APAsyncImageView!
    @IBOutlet weak var movieBackDropImageView: APAsyncImageView!
    @IBOutlet weak var moviewNameLabel: UILabel!
    @IBOutlet weak var moviewRatingLabel: UILabel!
    @IBOutlet weak var contentRatingLabel: UILabel!
    @IBOutlet weak var moviewOverviewLabel: UILabel!
    @IBOutlet weak var movieLanguageLabel: UILabel!
    
    var movieData: MovieResult? {
        didSet {
            guard let data = movieData else { return }
            moviewNameLabel.text = data.originalTitle
            moviewRatingLabel.text = String(format: "%.1f/10", data.voteAverage)
            moviewOverviewLabel.text = data.overview
            contentRatingLabel.text = data.adult ? "Rated NC-17" : nil
            movieLanguageLabel.text = data.originalLanguage
            let posterEndPoint = data.posterPath
            let backDropEndPoint = data.backdropPath ?? ""
            let posterBaseURL = NetworkRouter.imageBaseURL
            moviePosterImageView.loadImage(withImageURL: posterBaseURL + posterEndPoint)
            movieBackDropImageView.loadImage(withImageURL: posterBaseURL + backDropEndPoint, UIImage(systemName: "photo.on.rectangle") ?? UIImage())
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
