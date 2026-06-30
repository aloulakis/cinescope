//
//  MovieItem.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 24/6/26.
//

import Foundation

struct MovieModel: Identifiable {
    let id: Int
    let title: String
    let posterPath: String
    let voteAverage: Double

    // pairnw to Response Apo to Movie kai krataw ta dedomena edw
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title ?? ""
        self.posterPath = movie.poster_path ?? ""
        self.voteAverage = movie.vote_average
    }
}
