//
//  DetailModels.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 25/6/26.
//
import Foundation

struct DetailModel {
    let adult: Bool?
    let backdropPath: URL?
    let belongsToCollection: CollectionSummary?
    let genres: [Genre]
    let id: Int
    let overview: String?
    let posterPath: URL?
    let year: String?
    let runtime: Int?
    let title: String?
    let voteAverage: String?
    
    init(details: MovieDetailsResponse) {
        self.adult = details.adult
        self.backdropPath = URL(string: "https://image.tmdb.org/t/p/w780/\(details.backdrop_path ?? "")")
        self.belongsToCollection = details.belongs_to_collection
        self.genres = details.genres ?? []
        self.id = details.id ?? 0
        self.overview = details.overview ?? ""
        self.posterPath = URL(string: "https://image.tmdb.org/t/p/w342/\(details.poster_path ?? "")")
        self.year = details.release_date ?? ""
        self.runtime = details.runtime ?? 0
        self.title = details.title ?? ""
        self.voteAverage = (String(format: "%.1f", details.vote_average))
    }
    
    var formattedRunTime: String {
        let hour = (runtime ?? 0) / 60
        let minutes = (runtime ?? 0) % 60

        return "\(hour)h \(minutes)m"
    }
    
    var formattedDate: String {
        let year = String((year ?? "").prefix(4))
        
        return year
    }
}
