//
//  MoviesResponse.swift
//  MoviesApp
//
//  Created by shaza kashlan on 1/9/22.
//

import Foundation


struct MoviesResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}
