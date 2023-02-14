//
//  MainViewController.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 11/02/23.
//

import UIKit

public enum MovieListType: Int, CaseIterable {
    case popular = 0, topRated, nowPlaying, upcoming
    var urlPath: String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .nowPlaying:
            return "now_playing"
        case .upcoming:
            return "upcoming"
        }
    }
    var typeTitle: String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        }
    }
}

class MainViewController: UIViewController {
    //MARK: - UI
    
    var segmentedControl: UISegmentedControl!
    
    let collectionView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .black
        
        return collection
    }()
    
    var settingsBarButton: UIBarButtonItem!
    
    let segmentedControlTitles = MovieListType.allCases.map { $0.typeTitle }
    
    
    //MARK: - Variables
    var movies: [Movie] = []
    var apiService = APIService()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.loadMovies()
    }
    
    //MARK: - Helper methods
    private func setupNavBarButtons() {
        settingsBarButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(settingsBarButtonAction))
        settingsBarButton.tintColor = .white
        
        self.navigationItem.rightBarButtonItem = settingsBarButton
    }
    
    private func setupSegmentedControl() {
        self.segmentedControl = UISegmentedControl(items: segmentedControlTitles)
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(sender:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        
        self.view.addSubview(segmentedControl)
        
        segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
    }
    
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        
        self.view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    
    private func setupViews() {
        self.title = "Movies"
        
        self.setupSegmentedControl()
        self.setupCollectionView()
        self.setupNavBarButtons()
    }
    
    private func loadMovies() {
        let loader = self.loader()
        apiService.fetchMovies(by: MovieListType(rawValue: self.segmentedControl.selectedSegmentIndex)!) { [weak self] movies, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
            }
            if let error = error {
                print(error)
            } else {
                self.movies = movies
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    //MARK: - Button Actions
    
    @IBAction private func settingsBarButtonAction() {
        let profileVC = ProfileViewController()
        
        self.navigationController?.present(profileVC, animated: true)
    }
    
    @IBAction private func segmentedValueChanged(sender: UISegmentedControl) {
        let movieType = MovieListType(rawValue: sender.selectedSegmentIndex)!
        let loader = self.loader()
        apiService.fetchMovies(by: movieType) { [weak self] movies, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
            }
            if let error = error {
                print(error)
            } else {
                self.movies = movies
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

}

//MARK: - Extension UICollectionViewDataSource, UICollectionViewDelegate
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        let movie = self.movies[indexPath.item]
        
        let movieCellViewModel = MovieCellViewModel(movie: movie)
        movieCellViewModel.configure(cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.item]
        
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.movie = movie
        
        self.navigationController?.show(movieDetailVC, sender: self)
    }
    
}

//MARK: - Extensions UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 3 * 16) / 2
        return .init(width: width, height: width * 1.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 16
    }
}
