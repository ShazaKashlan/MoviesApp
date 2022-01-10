//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by shaza kashlan on 1/8/22.
//

import Foundation

protocol MovieDetailsViewModelProtocol : AnyObject {
    var movieData: Observable<MovieResponse?> { get }
    func loadMovieDetail(movieId: Int, completion: @escaping () -> Void)
}

class MovieDetailsViewModel : MovieDetailsViewModelProtocol {
    var movieData: Observable<MovieResponse?> {
        return _movieDetails
    }
    
    private var _movieDetails: Observable<MovieResponse?> = Observable(nil)
    private let movieDetailService : MovieDetailServiceProtocol!
    
    init(movieDetailService: MovieDetailServiceProtocol) {
        self.movieDetailService = movieDetailService
    }
    
    func loadMovieDetail(movieId: Int, completion: @escaping () -> Void) {
        movieDetailService.getMovieDetail(movieId: movieId) {[weak self] (movieDetail) in
            if let movieDetail = movieDetail {
                self?._movieDetails.value = movieDetail
            }
            completion()
        }
    }
}
