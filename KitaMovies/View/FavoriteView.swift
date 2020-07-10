//
//  FavoriteView.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 09/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//

import Foundation
import UIKit


extension FavoriteViewController {
    
    
    func setupViews() {
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Favorite"
        
        tableView.register(MoviesCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
}
