//
//  Movie.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 12/02/23.
//

import Foundation

struct Movie: Codable {
    let adult : Bool
    let backdropPath : String?
    let genreIds : [Int]
    let id : Int
    let originalLanguage : String
    let originalTitle : String
    let overview : String
    let popularity : Double
    let posterPath : String?
    let releaseDate : String
    let title : String
    let video : Bool
    let voteAverage : Double
    let voteCount : Int
    
    init(movieEnt: MovieEntity) {
        self.adult = false
        self.backdropPath = movieEnt.backdropPath
        self.id = Int(movieEnt.id ?? "") ?? 0
        self.genreIds = []
        self.originalTitle = ""
        self.originalLanguage = ""
        self.overview = movieEnt.overview ?? ""
        self.popularity = 0.0
        self.posterPath = movieEnt.posterPath
        self.releaseDate = movieEnt.releaseDate ?? ""
        self.title = movieEnt.title ?? ""
        self.video = false
        self.voteCount = Int(movieEnt.voteCount)
        self.voteAverage = movieEnt.averageVote
    }
}
