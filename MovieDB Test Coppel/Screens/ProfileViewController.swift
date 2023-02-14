//
//  ProfileViewController.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 12/02/23.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    let profileImageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle.fill")
        
        return imageView
    }()
    
    let usernameLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = UserData.username
        
        
        return label
    }()
    
    let favoriteHeaderLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 93/255, green: 191/255, blue: 108/255, alpha: 1)
        label.text = "Favorites Shows"
        
        return label
    }()
    
    let collectionView: UICollectionView! = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        
        return collection
    }()
    
    lazy var coreDataStack = CoreDataStack(modelName: "MovieDBModel")
    var movies: [MovieEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.movies = self.fetchMovies()
        self.collectionView.reloadData()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .black
        self.setupProfileImageView()
        self.setupUsernameLabel()
        self.setupFavoriteHeaderLabel()
        self.setupCollectionView()
        
    }
    
    private func setupProfileImageView() {
        self.view.addSubview(profileImageView)
        
        profileImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func setupUsernameLabel() {
        self.view.addSubview(usernameLabel)
        
        usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 0).isActive = true
    }
    
    private func setupFavoriteHeaderLabel() {
        self.view.addSubview(favoriteHeaderLabel)
        
        favoriteHeaderLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16).isActive = true
        favoriteHeaderLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        
    }
    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.topAnchor.constraint(equalTo: favoriteHeaderLabel.bottomAnchor, constant: 16).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func fetchMovies() -> [MovieEntity] {
        
        let movieFetch: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        do {
          let results = try coreDataStack.managedContext.fetch(movieFetch)
          return results
          
        } catch let error as NSError {
          print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return []
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        let movie = self.movies[indexPath.item]
        let movieViewModel = MovieCellViewModel(movieEntity: movie)
        
        movieViewModel.configure(cell)
        
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
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
