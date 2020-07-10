//
//  MoviesCell.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 04/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//

import Foundation
import UIKit


class MoviesCell: UITableViewCell {
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = nil
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the text for the title of our book inside of our cell"
        label.textColor = .black
        label.numberOfLines = 2
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "This is some description for the movie that we have in this row"
        label.numberOfLines = 2
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        addSubview(posterImageView)
        posterImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        
        posterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
        
        addSubview(overviewLabel)
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        overviewLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12).isActive = true
        overviewLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        //overviewLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
