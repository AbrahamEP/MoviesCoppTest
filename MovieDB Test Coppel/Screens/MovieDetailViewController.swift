//
//  MovieDetailViewController.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 12/02/23.
//

import Foundation
import UIKit
import ImageSlideshow
import CoreData

class MovieDetailViewController: UIViewController {
    //MARK: - UI
    let movieDetailView: MovieDetailView! = {
        let view = MovieDetailView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //MARK: - Variables
    var movie: Movie!
    var movieDetailViewModel: MovieDetailViewModel!
    var currentMovieEntity: MovieEntity?
    lazy var coreDataStack = CoreDataStack(modelName: "MovieDBModel")
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.movieDetailViewModel = MovieDetailViewModel(movie: self.movie)
        self.movieDetailViewModel.configure(self.movieDetailView)
        self.movieDetailViewModel.checkIsFavMovie(movie) { [movieDetailView] isFavMovie, movieEntity in
            guard let movieDetailView = movieDetailView else { return }
            self.currentMovieEntity = movieEntity
            self.movieDetailViewModel.setIsFavoriteMovie(movieDetailView, isFav: isFavMovie)
        }
        
        self.movieDetailView.delegate = self
    }
    
    
    //MARK: - Helper methods
    private func setupViews() {
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.view.addSubview(self.movieDetailView)
        self.movieDetailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.movieDetailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.movieDetailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.movieDetailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
//    private func checkIsFavMovie() {
//        let movieId = "\(self.movie.id)"
//        let movieFetch: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
//        movieFetch.predicate = NSPredicate(format: "id = %@", movieId)
//
//        do {
//          let results = try coreDataStack.managedContext.fetch(movieFetch)
//          if !results.isEmpty {
//              self.currentMovieEntity = results.first!
//              self.movieDetailView.favoriteButton.setTitle("Favorito", for: .normal)
//              self.movieDetailView.isFav = true
//          } else {
//              self.movieDetailView.isFav = false
//              self.movieDetailView.favoriteButton.setTitle("NO Favorito", for: .normal)
//          }
//
//        } catch let error as NSError {
//          print("Fetch error: \(error) description: \(error.userInfo)")
//        }
//    }
    
}

extension MovieDetailViewController: MovieDetailViewDelegate {
    
    func didPressedFavButton(_ view: MovieDetailView, isFav: Bool) {
        print("Favorite button pressed in ViewController")
        self.movieDetailViewModel.setIsFavoriteMovie(self.movieDetailView, isFav: isFav)
        if isFav {
            //Save movie
            let movieEntity = MovieEntity(context: self.coreDataStack.managedContext)
            
            movieEntity.backdropPath = self.movie.backdropPath
            movieEntity.posterPath = self.movie.posterPath
            movieEntity.id = "\(self.movie.id)"
            movieEntity.voteCount = Int32(self.movie.voteCount)
            movieEntity.overview = self.movie.overview
            movieEntity.releaseDate = self.movie.releaseDate
            movieEntity.averageVote = self.movie.voteAverage
            movieEntity.title = self.movie.title
            
            self.coreDataStack.saveContext()
            
            
        } else {
            //delete movie
            guard let movieEntity = self.currentMovieEntity else { return }
            let objectToDelete = self.coreDataStack.managedContext.object(with: movieEntity.objectID)
            self.coreDataStack.managedContext.delete(objectToDelete)
            self.coreDataStack.saveContext()
        }
        
        
    }
}
