//
//  CreditsModel.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 29/6/26.
//
import Foundation

struct CreditsModel {
    let id: Int?
    let cast: [Cast]?
    let crew: [Crew]?
    
    init(credits: CreditsResponse) {
        self.id = credits.id ?? 0
        self.cast = credits.cast ?? []
        self.crew = credits.crew ?? []
    }
}
