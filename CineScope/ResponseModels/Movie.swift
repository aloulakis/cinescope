//
//  MovieDTO.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//
import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    let release_date: String?
    let vote_average: Double?
}
