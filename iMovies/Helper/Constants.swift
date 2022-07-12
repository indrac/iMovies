//
//  Constants.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 05/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//

import Foundation

class Constants {
    
    static let categories = ["Popular": "popular", "Now Playing": "now_playing", "Upcoming": "upcoming", "Top Rated": "top_rated"]
    static let BaseImageURL = "https://image.tmdb.org/t/p/w500/"
    
    private static let Domain = "https://api.themoviedb.org"
    private static let Route = "/3/movie/"
    private static let BaseUrl =  Domain + Route
    
    static var BaseURL:String{
        return BaseUrl
    }
    
    static let EmptyString = ""
    static let Category = "Category"
    static let Cancel = "Cancel"
    static let Synopsis = "Synopsis"
    
    static let ApiKey = "api_key"
    static let PrivateKey = "cff1b4be8be0e8121d606de41ef8bca7"
    static let Language = "language"
    static let USLanguage = "en-US"
    static let Page = "page"
    
    // CoreData
    static let CoreDataEntityName = "MovieDatabase"
    static let DataExist = "Exist"
    
}
