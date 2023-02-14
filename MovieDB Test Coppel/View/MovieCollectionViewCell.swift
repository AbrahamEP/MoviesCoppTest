//
//  MovieCollectionViewCell.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 11/02/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MovieCollectionViewCell"
    
    let movieImageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    let movieNameLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(red: 93/255, green: 191/255, blue: 108/255, alpha: 1)
        
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(red: 93/255, green: 191/255, blue: 108/255, alpha: 1)
        
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(red: 93/255, green: 191/255, blue: 108/255, alpha: 1)
        
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 4
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }
    
    private func setupViews() {
        self.contentView.backgroundColor = UIColor(red: 25/255, green: 39/255, blue: 45/255, alpha: 1)
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
        self.setupMovieImageViewConstraints()
        self.setupMovieNameLabelConstraints()
        self.setupReleaseDateLabelConstraints()
        self.setupRatingLabelConstraints()
        self.setupDescriptionLabelConstraints()
    }
    
    private func setupMovieImageViewConstraints() {
        self.addSubview(movieImageView)
        
        movieImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55).isActive = true
    }
    
    private func setupMovieNameLabelConstraints() {
        self.addSubview(movieNameLabel)
        
        movieNameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 0).isActive = true
        movieNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        movieNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        movieNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupReleaseDateLabelConstraints() {
        self.addSubview(releaseDateLabel)
        
        releaseDateLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 10).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        releaseDateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupRatingLabelConstraints() {
        self.addSubview(ratingLabel)
        
        ratingLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 10).isActive = true
        ratingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: releaseDateLabel.trailingAnchor, constant: 4).isActive = true
        ratingLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupDescriptionLabelConstraints() {
        self.addSubview(descriptionLabel)
        
        descriptionLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
    }
}
