//
//  CollectionParts.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 22/6/26.
//
import Foundation

struct CollectionParts: Decodable {
    let adult: Bool
    let backdrop_path: String?
    let id: Int
    let name: String?
    let overview: String?
    let poster_path: String?
    let genre_ids: [Int]
}
