//
//  DetailViewController.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 05/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {

    private(set) var viewModel: DetailViewModel = DetailViewModel()
    private(set) var database: CoreDataManager = CoreDataManager()
    private(set) var favoriteImageView: UIButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
        searchFavoritesData()
    }
    
    func favoritingMovie(){
        database.create(self.viewModel.movieTitle, self.viewModel.overview, self.viewModel.posterURL, self.viewModel.releaseDate, completion: { response in
            switch response {
            case .failure(let err):
                print(err)
            case .success:
                print("Success save data to database")
            }
        })
    }
    
    @objc func searchFavoritesData() {
        database.search(title: self.viewModel.movieTitle, completion: { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let res):
                if res == "Exist" {
                    let favoritImage = UIImage(named: "iconGrayFavorite")?.withRenderingMode(.alwaysTemplate)
                    self.favoriteImageView.setImage(favoritImage, for: .normal)
                    self.favoriteImageView.tintColor = .orange
                    
                    let deleteButton = UITapGestureRecognizer(target: self, action: #selector(self.DeleteAlert))
                    self.favoriteImageView.addGestureRecognizer(deleteButton)
                } else {
                    let favoritImage = UIImage(named: "iconGrayFavorite")?.withRenderingMode(.alwaysTemplate)
                    self.favoriteImageView.setImage(favoritImage, for: .normal)
                    self.favoriteImageView.tintColor = .white
                    
                    let favoriteButton = UITapGestureRecognizer(target: self, action: #selector(self.SaveAlert))
                    self.favoriteImageView.addGestureRecognizer(favoriteButton)
                }
                print(res)
            }
        })
    }
    
}
