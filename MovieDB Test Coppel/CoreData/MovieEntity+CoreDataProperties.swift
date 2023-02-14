//
//  MovieEntity+CoreDataProperties.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 13/02/23.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var backdropPath: String?
    @NSManaged public var voteCount: Int32
    @NSManaged public var averageVote: Double
    @NSManaged public var overview: String?

}

extension MovieEntity : Identifiable {

}
