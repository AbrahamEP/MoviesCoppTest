//
//  APIService.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 12/02/23.
//

import Foundation

enum LoginAccessType {
    case granted
    case rejected
}

class APIService {
    private let baseUrlString = "https://api.themoviedb.org/3"
    static let baseImageUrlString = "https://image.tmdb.org/t/p/w500"
    
    private var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: "1a48730d4857aee7373a03e2c418c44f"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        return urlComponents
    }
    
    func login(with username: String, password: String, completion: @escaping (LoginAccessType) -> Void) {
        guard username == UserData.username, password == UserData.password else {
            
            completion(.rejected)
            return
        }
        completion(.granted)
    }
    
    func fetchMovies(by type: MovieListType, completion: @escaping ([Movie], String?) -> Void) {
        var urlComponents = self.urlComponents
        urlComponents.path = "/3/movie/\(type.urlPath)"
        
        guard let url = urlComponents.url else {
            return
        }
        print("URL from components: \(url.absoluteString)")
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completion([], String(describing: error))
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion([], "Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let filmSummary = try? decoder.decode(MovieResults.self, from: data) {
                    completion(filmSummary.results, nil)
                }
                
            }
        })
        task.resume()
        
    }
}
