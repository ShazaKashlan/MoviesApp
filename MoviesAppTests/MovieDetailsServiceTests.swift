//
//  MovieDetailsServiceTests.swift
//  MoviesAppTests
//
//  Created by shaza kashlan on 1/9/22.
//


import XCTest
@testable import MoviesApp


class MovieDetailServiceTests: XCTestCase {

    var sut : MovieDetailServiceProtocol!
    
    override func setUp() {

        super.setUp()
        
      
        setupData()
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func setupData() {
        sut = MovieDetailService()
    }
    
    func testGetMovieDetail() {
        //Given
        setupData()
        
        //When
        let expected = XCTestExpectation(description: "MovieDetailService load movie detail and runs the callback closure")
        sut.getMovieDetail(movieId: 464052) { (movieDetail) in
            
            //Then
            XCTAssertNotNil(movieDetail)
            
            // fulfill the expectation in the async callback
            expected.fulfill()
            
            // Wait for the expectation to be fulfilled
            self.wait(for: [expected], timeout: 10.0)//wait 10 seconds
        }

    }

}

