//
//  TrendingMoviesService.swift
//  MoviesApp
//
//  Created by shaza kashlan on 1/6/22.
//

import Foundation


protocol TrendingMoviesServiceProtocol : AnyObject {
    func fetchTrendingMovies(pageNumber: Int, completion: @escaping ([Movie]?) -> Void)
}

class TrendingMoviesService : TrendingMoviesServiceProtocol {
    
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    
    func fetchTrendingMovies(pageNumber: Int, completion: @escaping ([Movie]?) -> Void) {
        dataTask?.cancel()
        
        guard let url = URL(string: String(format: Domain.trendingMoviesUrl(), "\(pageNumber)") ) else {
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data {
                var response: MoviesResponse
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    response = try decoder.decode(MoviesResponse.self, from: data)
                } catch _ as NSError {
                    return
                }
                
                guard let array = response.results as? [Movie] else {
                    return
                }
                
                DispatchQueue.main.async {
                    completion(array)
                }
            }
        }
        
        dataTask?.resume()
    }
}
