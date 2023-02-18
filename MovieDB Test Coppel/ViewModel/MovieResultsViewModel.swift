//
//  MovieResultsViewModel.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 17/02/23.
//

import Foundation

class MovieResultsViewModel {
    var currentPage = 1
    var totalItems: Int {
        return self.movieResults.totalResults
    }
    var movieResults = MovieResults()
    var movies: [Movie] = []
    
    private var apiService = APIService()
    
    func fetchMovies(by type: MovieListType, completion: @escaping (MovieResults?, String?) -> Void) {
        self.apiService.fetchMovies(by: type) { movieResult, errorMessage in
            if let movieResult = movieResult {
                self.currentPage = 1
                self.movieResults = movieResult
                self.movies = movieResult.results
            }
            completion(movieResult, errorMessage)
        }
    }
    
    func loadMoreMovies(by type: MovieListType, completion: @escaping (MovieResults?, String?) -> Void)
    {
        currentPage += 1
        
        self.apiService.fetchMoreMovies(by: currentPage, of: type) { results, errorMessage in
            if let results = results {
                self.movieResults = results
                self.movies = self.movies + results.results
            }
            completion(results, errorMessage)
        }
    }
}
