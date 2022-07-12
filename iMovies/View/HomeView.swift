//
//  HomeView.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 04/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//

import Foundation
import UIKit


extension HomeViewController {
    
    func setupViews() {
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
        navigationItem.title = appName
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "iconFavorite.png"), for: .normal)
        button.addTarget(self, action: #selector(printing), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        let leftBarButton = UIBarButtonItem(title: Constants.Category, style: .plain, target: self, action: #selector(showAlert))
        leftBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        navigationItem.leftBarButtonItem = leftBarButton
    
        tableView.register(MoviesCell.self, forCellReuseIdentifier: "cellId")
    }
    
    @objc func printing(){
        let favoriteVC = FavoriteViewController()
        self.navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        Constants.categories.forEach({ action in
            alert.addAction(UIAlertAction(title: action.key, style: .default, handler: { [weak self] _ in
                self?.category = action.value
                self?.callAPI()
                print(action.value)
            }))
        })
        alert.addAction(UIAlertAction(title: Constants.Cancel, style: .destructive, handler: nil))
        self.present(alert, animated: true)
    }
    
    func callAPI() {
        viewModel.fetchMovies(category: &category, completion: { (response) in
            DispatchQueue.main.async {
                switch response {
                case .failure(let err):
                    print(err)
                case .success(let res):
                    self.movies = res.results
                    self.tableView.reloadData()
                }
            }
        })
    }
}
