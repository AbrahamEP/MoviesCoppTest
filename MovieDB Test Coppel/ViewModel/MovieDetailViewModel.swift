//
//  MovieDetailViewModel.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 13/02/23.
//

import Foundation
import ImageSlideshow
import CoreData

struct MovieDetailViewModel {
    var posterPath: String?
    var backdropPath: String?
    var title: String
    var releaseDate: String
    var overview: String
    var voteAverage: Double
    var voteCount: Int
    var isFavorite: Bool
    var movieId: String
    
    private var coreDataStack = CoreDataStack(modelName: "MovieDBModel")
    
    init(movie: Movie) {
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        self.voteAverage = movie.voteAverage
        self.voteCount = movie.voteCount
        self.isFavorite = false
        self.movieId = "\(movie.id)"
    }
    
    func checkIsFavMovie(_ movie: Movie, completion: (Bool, MovieEntity?) -> Void) {
        
        let movieId = "\(movie.id)"
        let movieFetch: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        movieFetch.predicate = NSPredicate(format: "id = %@", movieId)
        let currentMovieEnt: MovieEntity?
        
        do {
            let results = try coreDataStack.managedContext.fetch(movieFetch)
            currentMovieEnt = results.first
            completion(!results.isEmpty, currentMovieEnt)
            
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
}

extension MovieDetailViewModel {
    func setIsFavoriteMovie(_ view: MovieDetailView, isFav: Bool) {
        view.isFav = isFav
        view.setFavoriteStarButton(isFav: isFav)
    }
    
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
