//
//  CrewModel.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 29/6/26.
//

import Foundation

struct CrewModel {
    let id: Int
    let name: String
    let profilePath: String
    let department: String
    let job: String
    
    init(crew: Crew) {
        self.id = crew.id ?? 0
        self.name = crew.name ?? ""
        self.profilePath = crew.profile_path ?? ""
        self.department = crew.department ?? ""
        self.job = crew.job ?? ""
    }
}
