//
//  MovieDetailViewModel.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 13/02/23.
//

import Foundation
import ImageSlideshow

struct MovieDetailViewModel {
    var posterPath: String?
    var backdropPath: String?
    var title: String
    var releaseDate: String
    var overview: String
    var voteAverage: Double
    var voteCount: Int
    var isFavorite: Bool
    
    init(movie: Movie) {
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        self.voteAverage = movie.voteAverage
        self.voteCount = movie.voteCount
        self.isFavorite = false
    }
}

extension MovieDetailViewModel {
    func configure(_ view: MovieDetailView) {
        view.titleLabel.text = self.title
        view.releaseDateLabel.text = self.releaseDate
        view.overviewLabel.text = self.overview
        view.voteCountLabel.text = "Votes: \(self.voteCount)"
        view.voteAverageLabel.text = "Avg: \(self.voteAverage.rounded())"
        guard let posterPath = self.posterPath, let backdropPath = self.backdropPath else { return }
        view.imageSlideShow.setImageInputs([
            AlamofireSource(urlString: APIService.baseImageUrlString + posterPath)!,
            AlamofireSource(urlString: APIService.baseImageUrlString + backdropPath)!
        ])
    }
}
