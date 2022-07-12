//
//  FavoriteViewController.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 09/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//

import UIKit

class FavoriteViewController: UITableViewController {
    
    private(set) var database: CoreDataManager = CoreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if database.retrieve().count > 0 { return database.retrieve().count } else { return 0 }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MoviesCell
        if database.retrieve().count > 0 {
            cell.titleLabel.text = database.retrieve()[indexPath.row].title
            cell.overviewLabel.text = database.retrieve()[indexPath.row].overview
            cell.posterImageView.kf.indicatorType = .activity
            cell.posterImageView.kf.setImage(with: URL(string: Constants.BaseImageURL + database.retrieve()[indexPath.row].poster_path), options: [.backgroundDecode,.cacheOriginalImage])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.viewModel.movieTitle = database.retrieve()[indexPath.row].title
        detailVC.viewModel.posterURL = database.retrieve()[indexPath.row].poster_path
        detailVC.viewModel.overview = database.retrieve()[indexPath.row].overview
        detailVC.viewModel.releaseDate = dateFormat(get: database.retrieve()[indexPath.row].release_date)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
