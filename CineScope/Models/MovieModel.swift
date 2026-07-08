//
//  MovieItem.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 24/6/26.
//

import Foundation

struct MovieModel: Identifiable, Codable {
    let id: Int
    let title: String?
    let posterPath: String?
    let voteAverage: Double?
    let backdropPath: String
   // var isFsvorite: Bool?

    // pairnw to Response Apo to Movie kai krataw ta dedomena edw
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title ?? ""
        self.posterPath = movie.poster_path ?? ""
        self.voteAverage = movie.vote_average ?? 0.0
        self.backdropPath = movie.backdrop_path ?? ""
//        self.isFsvorite = SingleTon.shared.isFavorite(id: id)
    }
    
    init(details: DetailModel) {
        self.id = details.id
        self.title = details.title ?? ""
        self.posterPath = details.posterPath ?? ""
        self.voteAverage = Double(details.voteAverage ?? "") ?? 0
        self.backdropPath = details.backDropPath ?? ""
    }
    

}
