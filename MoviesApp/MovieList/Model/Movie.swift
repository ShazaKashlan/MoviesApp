//
//  Movie.swift
//  MoviesApp
//
//  Created by shaza kashlan on 1/6/22.
//

import Foundation

struct Movie: Codable {
    public let id: Int
    public let title: String
    public let backdropPath: String?
    public let posterPath: String?
    public let overview: String
    public let adult: Bool
    public let releaseDate:String?
    public let runtime:Int?   
}



