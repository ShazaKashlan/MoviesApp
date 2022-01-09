//
//  MovieDetailsService.swift
//  MoviesApp
//
//  Created by shaza kashlan on 1/8/22.
//

import Foundation

import Foundation
protocol MovieDetailServiceProtocol : AnyObject {
    func getMovieDetail(movieId: Int, completion: @escaping (MovieResponse?) -> Void)
}

class MovieDetailService : MovieDetailServiceProtocol {
    
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    
    func getMovieDetail(movieId: Int, completion: @escaping (MovieResponse?) -> Void) {
        dataTask?.cancel()
        
        guard let url = URL(string: String(format: Domain.movieDetailsUrl(), "\(movieId)") ) else {
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data {
                
                var response: MovieResponse?
                
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    response = try decoder.decode(MovieResponse.self, from: data)
                } catch _ as NSError {
                    return
                }
                
                guard let result = response else {
                    return
                }
                
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
        
        dataTask?.resume()
    }
}
