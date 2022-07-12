//
//  Movie.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 04/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//

import Foundation


class Movie: Decodable {
    
    var results: [Movies]
    
}

struct Movies: Decodable {
    
    var title: String
    var overview: String
    var release_date: String
    var poster_path: String
}
