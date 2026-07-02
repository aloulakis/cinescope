//
//  CastModel.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 29/6/26.
//

struct CastModel: Identifiable {
    let id: Int
    let name: String?
    let profilePath: String?
    let character: String?
    
    
    init (cast: Cast) {
        self.id = cast.id ?? 0
        self.name = cast.name ?? ""
        self.profilePath = cast.profile_path ?? "No Image"
        self.character = cast.character ?? ""
    }
}
