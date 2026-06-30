//
//  CollectionSummary.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 22/6/26.
//

import Foundation

struct CollectionSummary: Decodable {
    let id: Int
    let name: String?
    let poster_path: String?
    let backdrop_path: String?
}
