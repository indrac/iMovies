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
    
}
