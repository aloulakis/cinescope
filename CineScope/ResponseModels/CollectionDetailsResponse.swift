//
//  CollectionDetailsResponse.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 22/6/26.
//
import Foundation

struct CollectionDetailsResponse: Decodable {
    let id: Int
    let name: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    let parts: [CollectionParts]
}
