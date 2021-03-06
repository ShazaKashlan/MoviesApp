//
//  MovieModelViewTest.swift
//  MoviesAppTests
//
//  Created by shaza kashlan on 1/9/22.
//
import XCTest
@testable import MoviesApp

class MovieListViewModelTests: XCTestCase {

    var sut : MovieListViewModel!
    var mockTrendingMoviesService: TrendingMoviesServiceProtocol!

    override func setUp() {

        super.setUp()
        
        setupData()
        
    }

    override func tearDown() {
        
        mockTrendingMoviesService = nil
        sut = nil

        super.tearDown()
    }
    
    func setupData() {
        mockTrendingMoviesService = TrendingMoviesService()
        sut = MovieListViewModel(trendingService: mockTrendingMoviesService)
    }

    
    func testFetchPopularMovies() {
        //Given
        setupData()
        
        let expected = XCTestExpectation(description: "MovieListViewModel fetchs trending movies and runs the callback closure")
        //When
        sut.fetchTrendingMovies(pageNumber: 1) {
 
            // fulfill the expectation in the async callback
            expected.fulfill()
        
        }
        wait(for: [expected], timeout: 10.0)
        
        //Then
        XCTAssertNotNil(self.sut.movieTrendigArray)
        
    }
    
    


}
