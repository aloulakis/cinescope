//
//  DetailsListResponse.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 22/6/26.
//
import Foundation

struct MovieDetailsResponse: Decodable {
    let adult: Bool
    let backdrop_path: String?
    let belongs_to_collection: CollectionSummary?
    let genres: [Genre]?
    let id: Int?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let runtime: Int?
    let title: String?
    let vote_average: Double
}
