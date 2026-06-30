//
//  DetailModels.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 25/6/26.
//

import Foundation

struct DetailModel {
    let adult: Bool
    let backDropPath: String
    let belongsToCollection: CollectionSummary?
    let genres: [Genre]
    let id: Int
    let overview: String
    let posterPath: String
    let year: String
    let runtime: Int
    let title: String
    let voteAverage: String
    
    init(details: MovieDetailsResponse) {
        self.adult = details.adult
        self.backDropPath = details.backdrop_path ?? ""
        self.belongsToCollection = details.belongs_to_collection
        self.genres = details.genres ?? []
        self.id = details.id ?? 0
        self.overview = details.overview ?? ""
        self.posterPath = details.poster_path ?? ""
        self.year = details.release_date ?? ""//String(details.release_date?.prefix(4) ?? "")
        self.runtime = details.runtime ?? 0
        self.title = details.title ?? ""
        self.voteAverage = (String(format: "%.1f", details.vote_average))
    }
    
    var formattedRunTime: String {
        let hour = runtime / 60
        let minutes = runtime % 60

        return "\(hour)h \(minutes)m"
    }
    
    var formattedDate: String {
        let year = String(year.prefix(4))
        
        return year
    }
}
