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
    
    private func fetchData(with url: URL, completion: @escaping (Data?, URLResponse?, String?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completion(nil, nil,String(describing: error))
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil, nil, "Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            guard let data = data else {
                return
            }

            completion(data, response, "Error: \(String(describing: error))")
            
        })
        task.resume()
    }
    
    func login(with username: String, password: String, completion: @escaping (LoginAccessType) -> Void) {
        guard username == UserData.username, password == UserData.password else {
            
            completion(.rejected)
            return
        }
        completion(.granted)
    }
    
    func fetchMovies(by type: MovieListType, completion: @escaping (MovieResults?, String?) -> Void) {
        var urlComponents = self.urlComponents
        urlComponents.queryItems?.append(URLQueryItem(name: "page", value: "1"))
        urlComponents.path = "/3/movie/\(type.urlPath)"
        
        guard let url = urlComponents.url else {
            completion(nil, "Error fetching movies")
            return
        }
        print("URL from components: \(url.absoluteString)")
        
        self.fetchData(with: url) { data, response, errorMessage in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let filmSummary = try? decoder.decode(MovieResults.self, from: data) {
                completion(filmSummary, nil)
            }
        }
    }
    
    func fetchMoreMovies(by page: Int, of type: MovieListType, completion: @escaping (MovieResults?, String?) -> Void) {
        var urlComponents = self.urlComponents
        urlComponents.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        urlComponents.path = "/3/movie/\(type.urlPath)"
        
        guard let url = urlComponents.url else {
            completion(nil, "Error fetching movies")
            return
        }
        self.fetchData(with: url) { data, response, errorMessage in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let filmSummary = try? decoder.decode(MovieResults.self, from: data) {
                completion(filmSummary, nil)
            }
        }
    }
}
