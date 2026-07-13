//
//  CastCrewList.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 22/6/26.
//
import Foundation

struct CreditsResponse: Decodable {
    let id: Int?
    let cast: [Cast]?
    let crew: [Crew]?
}
