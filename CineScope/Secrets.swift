//
//  Secrets.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 22/6/26.
//

import Foundation

struct Secrets {
    static var tmdbToken: String {
        guard let path = Bundle.main.path(forResource: "secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let token = dict["TMDBAccessToken"] as? String
        else { fatalError("secrets.plist not found or TMDBAccessToken missing") }
        return token
    }
}
