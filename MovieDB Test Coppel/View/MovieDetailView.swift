//
//  MovieDetailView.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 13/02/23.
//

import Foundation
import UIKit
import ImageSlideshow

protocol MovieDetailViewDelegate {
    func didPressedFavButton(_ view: MovieDetailView, isFav: Bool)
}

class MovieDetailView: UIView {
    
    //MARK: - UI
    let imageSlideShow: ImageSlideshow! = {
        let slide = ImageSlideshow(frame: .zero)
        slide.translatesAutoresizingMaskIntoConstraints = false
        slide.backgroundColor = .white
        return slide
    }()
    
    let titleLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(red: 93/255, green: 191/255, blue: 108/255, alpha: 1)
        label.text = "Title Test"
        
        return label
    }()
    
    let releaseDateLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(red: 93/255, green: 191/255, blue: 108/255, alpha: 1)
        label.text = "Date Test"
        return label
    }()
    
    let overviewLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Overview Test Overview Test Overview Test Overview Test Overview Test Overview Test Overview Test Overview Test Overview Test Overview Test"
        return label
    }()
    
    let voteAverageLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(red: 93/255, green: 191/255, blue: 108/255, alpha: 1)
        label.text = "Average Test"
        return label
    }()
    
    let voteCountLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(red: 93/255, green: 191/255, blue: 108/255, alpha: 1)
        label.text = "Vote count Test"
        return label
    }()
    
    private let emptyHeartImage: UIImage! = {
        let image = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        
        return image
    }()
    
    private let fullHeartImage: UIImage! = {
        let image = UIImage(named: "favorite-heart")?.withRenderingMode(.alwaysTemplate)
        
        return image
    }()
    
    let favoriteImageButton: UIImageView! = {
        let heartImage = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: heartImage)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.tintColor = .red
        
        return imageView
    }()
    
    //MARK: - Variables
    var isFav = false
    var delegate: MovieDetailViewDelegate?
    
    //MARK: - Lifecycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    //MARK: - Helper methods
    private func setupViews() {
        self.backgroundColor = .black
        
        self.setupFavoriteImageButton()
        self.setupImageSlide()
        self.setupTitleLabel()
        self.setupAverageLabel()
        self.setupReleaseDateLabel()
        self.setupVoteCountLabel()
        
        self.setupOverviewLabel()
    }
    
    private func setupImageSlide() {
        self.addSubview(self.imageSlideShow)
        self.imageSlideShow.topAnchor.constraint(equalTo: self.favoriteImageButton.bottomAnchor, constant: 16).isActive = true
        self.imageSlideShow.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.imageSlideShow.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.imageSlideShow.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35).isActive = true
    }
    
    private func setupTitleLabel() {
        self.addSubview(self.titleLabel)
        self.titleLabel.topAnchor.constraint(equalTo: self.imageSlideShow.bottomAnchor, constant: 16).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupAverageLabel() {
        self.addSubview(self.voteAverageLabel)
        self.voteAverageLabel.topAnchor.constraint(equalTo: self.imageSlideShow.bottomAnchor, constant: 16).isActive = true
        self.voteAverageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupReleaseDateLabel() {
        self.addSubview(self.releaseDateLabel)
        self.releaseDateLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        self.releaseDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.releaseDateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupVoteCountLabel() {
        self.addSubview(self.voteCountLabel)
        self.voteCountLabel.topAnchor.constraint(equalTo: self.voteAverageLabel.bottomAnchor, constant: 8).isActive = true
        self.voteCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupFavoriteImageButton() {
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.addTarget(self, action: #selector(favoriteButtonAction))
        self.favoriteImageButton.addGestureRecognizer(tapGesture)
        
        self.addSubview(self.favoriteImageButton)
        self.favoriteImageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        self.favoriteImageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.favoriteImageButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.favoriteImageButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupOverviewLabel() {
        self.addSubview(self.overviewLabel)
        self.overviewLabel.topAnchor.constraint(equalTo: self.releaseDateLabel.bottomAnchor, constant: 80).isActive = true
        self.overviewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.overviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: 8).isActive = true
    }
    
    func setFavoriteStarButton(isFav: Bool) {
        
        self.favoriteImageButton.image = isFav ? self.fullHeartImage : self.emptyHeartImage
    }
    
    //MARK: - Actions
    @objc private func favoriteButtonAction() {
        print("Favorite button pressed")
        isFav.toggle()
        self.setFavoriteStarButton(isFav: isFav)
        delegate?.didPressedFavButton(self, isFav: isFav)
    }
    
}
