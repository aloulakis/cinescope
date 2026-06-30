//
//  MovieListResponse.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 21/6/26.
//

import Foundation


struct MovieListResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
