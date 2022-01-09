//
//  TrendingMovieListServiceTests.swift
//  MoviesAppTests
//
//  Created by shaza kashlan on 1/9/22.
//

import XCTest
@testable import MoviesApp

class TrendingMovieListServiceTests: XCTestCase {

    var sut : TrendingMoviesServiceProtocol!
    
    override func setUp() {

        super.setUp()
        
      
        setupData()
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func setupData() {
        sut = TrendingMoviesService()
    }
    
    func testFetchPopularMovies() {
        //Given
        setupData()
        
        let expected = XCTestExpectation(description: "TrendingMoviesService fetchs popular movies and runs the callback closure")
        //When
        sut.fetchTrendingMovies(pageNumber: 1) {[weak self] (results) in
            
            //Then
            XCTAssertNotNil(results)
            
            // fulfill the expectation in the async callback
            expected.fulfill()
            
            // Wait for the expectation to be fulfilled
            self?.wait(for: [expected], timeout: 10.0)//wait 10 seconds
        }
        
    }

}
