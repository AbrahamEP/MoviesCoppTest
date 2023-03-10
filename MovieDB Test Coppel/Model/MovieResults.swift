//
//  MovieResults.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 12/02/23.
//

import Foundation

struct MovieResults: Codable {
    var page: Int = 1
    var totalPages: Int = 0
    var totalResults: Int = 0
    var results: [Movie] = []
}
