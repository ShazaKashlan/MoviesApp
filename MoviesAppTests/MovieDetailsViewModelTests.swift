//
//  MovieDetailsViewModelTest.swift
//  MoviesAppTests
//
//  Created by shaza kashlan on 1/9/22.
//

import XCTest
@testable import MoviesApp

class MovieDetailViewModelTests: XCTestCase {

    var sut : MovieDetailsViewModel!
    var mockMovieDetailService : MovieDetailServiceProtocol!

    override func setUp() {

        super.setUp()
        
        setupData()
        
    }

    override func tearDown() {
        mockMovieDetailService = nil
        sut = nil

        super.tearDown()
    }
    
    func setupData() {
        mockMovieDetailService = MovieDetailService()
        sut = MovieDetailsViewModel(movieDetailService: mockMovieDetailService)
    }

    func testLoadMovieDetail() {
        //Given
        setupData()
        
        let expected = XCTestExpectation(description: "MovieDetailViewModel fetch movie details  and runs the callback closure")
        //When
        sut.loadMovieDetail(movieId: 464052) {
            // fulfill the expectation in the async callback
            expected.fulfill()
        }
        
        wait(for: [expected], timeout: 10.0)
        //Then
        XCTAssertNotNil(self.sut.movieData)
        
    }
    
}
