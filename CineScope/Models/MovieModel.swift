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
    let posterPath: URL?
    let voteAverage: Double?
    let backdropPath: URL?
    var isFavorite: Bool?

    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title ?? ""
        self.posterPath = URL(string: "https://image.tmdb.org/t/p/w342/\(movie.poster_path ?? "")")
        self.voteAverage = movie.vote_average ?? 0.0
        self.backdropPath = URL(string: "https://image.tmdb.org/t/p/w780/\(movie.backdrop_path ?? "")")
        self.isFavorite = UserStorage.shared.isFavorite(id: movie.id)
    }
    
    init(details: DetailModel) {
        self.id = details.id
        self.title = details.title ?? ""
        self.posterPath = details.posterPath
        self.voteAverage = Double(details.voteAverage ?? "") ?? 0
        self.backdropPath = details.backdropPath
        self.isFavorite = UserStorage.shared.isFavorite(id: details.id)
    }
}
