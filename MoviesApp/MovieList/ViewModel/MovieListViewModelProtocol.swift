//
//  MovieListViewModel.swift
//  MoviesApp
//
//  Created by shaza kashlan on 1/8/22.
//

import Foundation


protocol MovieListViewModelProtocol : AnyObject {
    var movieTrendigArray: Observable<[Movie]> { get }
    var pageNumber : Int { get set }
    
    //MARK: - fetch movies
    func fetchTrendingMovies(pageNumber: Int, completion: @escaping () -> Void)
}

class MovieListViewModel : MovieListViewModelProtocol {
    
    var pageNumber: Int
    var _movieTrendingArray: Observable<[Movie]> = Observable([])
    var movieTrendigArray: Observable<[Movie]> {
        return _movieTrendingArray
    }
    
    private var _trendingService : TrendingMoviesServiceProtocol!
    private var _movieDetailService: MovieDetailServiceProtocol!
    
    init( trendingService: TrendingMoviesServiceProtocol, movieDetailService: MovieDetailServiceProtocol) {
        self._trendingService = trendingService
        self._movieDetailService = movieDetailService
        self.pageNumber = 1
    }
    
    func fetchTrendingMovies(pageNumber: Int, completion: @escaping () -> Void) {
        print("fetchMovies at page number \(pageNumber)")
        _trendingService.fetchTrendingMovies(pageNumber: pageNumber) {[weak self] (jsonArray) in
            if let jsonArray = jsonArray {
                print(jsonArray.count)
                self?.movieTrendigArray.value.append(contentsOf: jsonArray)
            }
            completion()
            
        }
    }
}

