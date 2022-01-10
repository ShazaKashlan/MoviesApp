//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by shaza kashlan on 1/8/22.
//

import Foundation

protocol MovieDetailsViewModelProtocol : AnyObject {
    var movieData: MovieResponse { get }
    func loadMovieDetail(movieId: Int, completion: @escaping () -> Void)
}

class MovieDetailsViewModel : MovieDetailsViewModelProtocol {
    
    var movieData: MovieResponse {
        return _movieDetails!
    }
    
    private var _movieDetails: MovieResponse?
    private let movieDetailService : MovieDetailServiceProtocol!
    
    init(movieDetailService: MovieDetailServiceProtocol) {
        self.movieDetailService = movieDetailService
    }
    func loadMovieDetail(movieId: Int, completion: @escaping () -> Void) {
        movieDetailService.getMovieDetail(movieId: movieId) {[weak self] (movieDetail) in
            if let movieDetail = movieDetail {
                self?._movieDetails = movieDetail
            }
            completion()
        }
    }
}
