//
//  Constants.swift
//  MoviesApp
//
//  Created by shaza kashlan on 1/9/22.
//

import UIKit

struct Domain {
    static var dev = "https://api.themoviedb.org"
    static var apiVersion = "/3/"
    static var assest = "https://image.tmdb.org/t/p/"
    static let apiKey = "api_key=c9856d0cb57c3f14bf75bdc6c063b8f3"

}
extension Domain {
    static func baseUrl() -> String {
        print(Domain.dev)
        return Domain.dev + Domain.apiVersion
    }
    static func trendingMoviesUrl() -> String {
        return baseUrl() + APIEndpoint.trendingMovies + Domain.apiKey + "&page=%@"
    }
    static func movieDetailsUrl() -> String {
        return baseUrl() + APIEndpoint.movieDetails + Domain.apiKey
    }
    
    static func assestUrl() -> String {
        return Domain.assest + "w154"
    }
    
}

struct Constants {
    static let inputFormatter : String = "YYYY-MM-dd"
    static let outputFormatter : String = "MMM dd, YYYY"
    static let backgroundColor = UIColor.black
    static let backgroundTableViewColor = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 1)
    static let titleHearderTableViewColor = UIColor(red: 252.0/255.0, green: 208.0/255.0, blue: 82.0/255.0, alpha: 1)
    static let backgroundHearderTableViewColor = UIColor(red: 64.0/255.0, green: 64.0/255.0, blue: 64.0/255.0, alpha: 1)
}


