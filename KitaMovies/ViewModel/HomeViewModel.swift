//
//  HomeViewModel.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 04/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//

import Foundation


class HomeViewModel {
    
    func fetchMovies(category: inout String, completion: @escaping (Result<Movie, Error>) -> ()) {
        
        let something = Constants.categories.first
        if category.isEmpty { category = something?.value ?? Constants.EmptyString}
        
        let urlMovies = Constants.BaseURL + category
        
        guard var urlComponents = URLComponents(string: urlMovies) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.ApiKey, value: Constants.PrivateKey),
            URLQueryItem(name: Constants.Language, value: Constants.USLanguage),
            URLQueryItem(name: Constants.Page, value: "1")
        ]
        
        guard let url = urlComponents.url else { return }
        print(url)
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let err = error {
                print(err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let json: Movie = try JSONDecoder().decode(Movie.self, from: data)
                completion(.success(json))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
        }).resume()
    }
    
}


