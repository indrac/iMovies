//
//  HomeViewController.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 04/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UITableViewController {
    
    var category = Constants.EmptyString
    var movies: [Movies]?
    private(set) var viewModel: HomeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MoviesCell
        guard let movie = movies, movie.count > 0 else { return cell }
        cell.titleLabel.text = movie[indexPath.row].title
        cell.overviewLabel.text = movie[indexPath.row].overview
        cell.posterImageView.kf.indicatorType = .activity
        cell.posterImageView.kf.setImage(with: URL(string: Constants.BaseImageURL + movie[indexPath.row].poster_path), options: [.backgroundDecode,.cacheOriginalImage])
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = movies, movie.count > 0 else { return }
        let detailVC = DetailViewController()
        detailVC.viewModel.movieTitle = movie[indexPath.row].title
        detailVC.viewModel.posterURL = movie[indexPath.row].poster_path
        detailVC.viewModel.overview = movie[indexPath.row].overview
        detailVC.viewModel.releaseDate = dateFormat(get: movie[indexPath.row].release_date)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
