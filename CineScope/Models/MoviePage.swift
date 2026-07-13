//
//  MoviePage.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 8/7/26.
//
import Foundation

struct MoviePage {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    
    init(response: MovieListResponse) {
        self.page = response.page
        self.results = response.results
        self.totalPages = response.total_pages
    }
}
