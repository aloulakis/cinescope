//
//  Endpoint.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import Foundation

enum Endpoint {
    case trending
    case popular
    case topRated
    case upComing
    case genres
    case details(id: Int)
    case credits(id: Int)
    case collectionDetails(collectionId: Int)
    case recommendations(id: Int)
    case search(query: String)

    
    var path: String {
        switch self {
        case .trending:
            return "/trending/movie/week"
            
        case .popular:
            return "/movie/popular"
            
        case .topRated:
            return "/movie/top_rated"
            
        case .upComing:
            return "/movie/upcoming"
            
        case .genres:
            return "/genre/movie/list"
            
        case .details(id: let id):
            return "/movie/\(id)"
            
        case .credits(id: let id):
            return "/movie/\(id)/credits"
        
        case .collectionDetails(collectionId: let id):
            return "/collection/\(id)"
            
        case .recommendations(id: let id):
            return "/movie/\(id)/recommendations"
            
        case .search:
            return "/search/movie"
        }
        

    }
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(query: let query):
            return [URLQueryItem(name: "query", value: query)]
        default:
            return []
        }
    }
}
