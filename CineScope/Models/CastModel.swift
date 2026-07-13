//
//  CastModel.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 29/6/26.
//
import Foundation

struct CastModel: Identifiable {
    let id: Int
    let name: String?
    let profilePath: URL?
    let character: String?
    
    
    init (cast: Cast) {
        self.id = cast.id ?? 0
        self.name = cast.name ?? ""
        self.profilePath = URL(string: "https://image.tmdb.org/t/p/w342/\(cast.profile_path ?? "")")
        self.character = cast.character ?? ""
    }
}
