//
//  MovieDatabase+CoreDataProperties.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 08/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieDatabase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDatabase> {
        return NSFetchRequest<MovieDatabase>(entityName: "MovieDatabase")
    }

    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var releasedate: String?
    @NSManaged public var poster: String?

}
