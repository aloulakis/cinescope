//
//  GenreResponse.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 21/6/26.
//
import Foundation

struct Genre: Decodable, Identifiable {
    let id: Int
    let name: String?
}
