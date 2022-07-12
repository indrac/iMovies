//
//  DetailView.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 05/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension DetailViewController {
    
   func setupLayout() {
       self.view.backgroundColor = .white
       navigationController?.navigationBar.prefersLargeTitles = false
       self.navigationController?.isNavigationBarHidden = true
       navigationController?.interactivePopGestureRecognizer?.delegate = self
   }
    
    func setupViews() {
        let tapBackButton = UITapGestureRecognizer(target: self, action: #selector(self.cellTappedMethod(_:)))
        
        let posterImageView: UIImageView = {
            let imageView = UIImageView(image: nil)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: URL(string: Constants.BaseImageURL + self.viewModel.posterURL), options: [.backgroundDecode,.cacheOriginalImage])
            return imageView
        }()
        
        let backImageView: UIImageView = {
            let image: UIImage = UIImage(named: "iconBack")!
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapBackButton)
            return imageView
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = self.viewModel.movieTitle
            label.textColor = .white
            label.numberOfLines = 2
            label.backgroundColor = UIColor.clear
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
            return label
        }()
        
        let dateLabel: UILabel = {
            let label = UILabel()
            label.text = self.viewModel.releaseDate
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            return label
        }()
        
        let synopsisLabel: UILabel = {
            let label = UILabel()
            label.text = Constants.Synopsis
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
            return label
        }()
        
        let overviewLabel: UILabel = {
            let label = UILabel()
            label.text = self.viewModel.overview
            label.textColor = .lightGray
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            return label
        }()
        
        let favoritImage = UIImage(named: "iconGrayFavorite")?.withRenderingMode(.alwaysOriginal)
        self.favoriteImageView.setImage(favoritImage, for: .normal)
        self.favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        self.favoriteImageView.contentMode = .scaleAspectFill
        self.favoriteImageView.clipsToBounds = true
        self.favoriteImageView.isUserInteractionEnabled = true
        
        
        self.view.addSubview(posterImageView)
        self.view.addSubview(backImageView)
        self.view.addSubview(favoriteImageView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(dateLabel)
        self.view.addSubview(synopsisLabel)
        self.view.addSubview(overviewLabel)
        
        NSLayoutConstraint.activate([
        posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
        posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        posterImageView.heightAnchor.constraint(equalToConstant: 350),
        
        backImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
        backImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        backImageView.heightAnchor.constraint(equalToConstant: 30),
        backImageView.widthAnchor.constraint(equalToConstant: 30),
        
        favoriteImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
        favoriteImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        favoriteImageView.heightAnchor.constraint(equalToConstant: 30),
        favoriteImageView.widthAnchor.constraint(equalToConstant: 30),
        
        titleLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -50),
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
        dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
        
        synopsisLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
        synopsisLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        
        overviewLabel.topAnchor.constraint(equalTo: synopsisLabel.bottomAnchor, constant: 20),
        overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        
        
        ])
    }
    
    
    
    @objc func cellTappedMethod(_ sender:AnyObject){
        self.navigationController?.popViewController(animated: true)
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
    
    func deleteMovie(){
        database.delete(self.viewModel.movieTitle, completion: { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success:
                print("Success delete favorite item")
                self.DeleteAlert()
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
    
    
    
    @objc func SaveAlert() {
        favoritingMovie()
        let favoritImage = UIImage(named: "iconGrayFavorite")?.withRenderingMode(.alwaysTemplate)
        self.favoriteImageView.setImage(favoritImage, for: .normal)
        self.favoriteImageView.tintColor = .orange
        
        searchFavoritesData()
    }
    
    @objc func DeleteAlert() {
        deleteMovie()
        let favoritImage = UIImage(named: "iconGrayFavorite")?.withRenderingMode(.alwaysTemplate)
        self.favoriteImageView.setImage(favoritImage, for: .normal)
        self.favoriteImageView.tintColor = .white
        
        searchFavoritesData()
    }
    
}
