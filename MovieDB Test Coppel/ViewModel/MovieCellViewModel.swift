//
//  MovieCellViewModel.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 12/02/23.
//

import Foundation
import SDWebImage
import UIKit

struct MovieCellViewModel {
    var imagePath: String?
    var title: String
    var rating: Double
    var overview: String
    var releaseDate: String
    
    init(movie: Movie) {
        self.imagePath = movie.posterPath
        self.title = movie.title
        self.rating = movie.voteAverage.rounded()
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
    }
    
    init(movieEntity: MovieEntity) {
        self.imagePath = movieEntity.posterPath
        self.title = movieEntity.title ?? ""
        self.rating = movieEntity.averageVote
        self.overview = movieEntity.overview ?? ""
        self.releaseDate = movieEntity.releaseDate ?? ""
    }
}

extension MovieCellViewModel {
    func configure(_ view: MovieCollectionViewCell) {
        view.movieNameLabel.text = self.title
        view.ratingLabel.text = "Score: \(self.rating)"
        view.descriptionLabel.text = self.overview
        view.releaseDateLabel.text = self.releaseDate
        guard let imagePath = self.imagePath else { return }
        view.movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)"), placeholderImage: UIImage(systemName: "person.circle.fill"))
    }
}
