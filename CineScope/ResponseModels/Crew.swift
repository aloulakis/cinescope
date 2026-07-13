//
//  Crew.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 22/6/26.
//
import Foundation

struct Crew: Decodable {
    let id: Int?
    let name: String?
    let profile_path: String?
    let department: String?
    let job: String?
}
