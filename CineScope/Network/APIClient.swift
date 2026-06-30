//
//  APIClinet.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import Foundation

protocol APIClientProtocol {
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class APIClient: APIClientProtocol {
    private let baseURL = "https://api.themoviedb.org/3"
    
    static let shared = APIClient()
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = makeURL(for: endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Secrets.tmdbToken)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        
        //print(String(data: data, encoding: .utf8) ?? "No data")
        
        let response = try JSONDecoder().decode(T.self, from: data)
        
        return response
    }
    
    private func makeURL(for endpoint: Endpoint) -> URL? {
        URL(string: baseURL + endpoint.path)
    }
}

//    func fetchTrending() async throws -> MovieListResponse {
//        return try await request(.trending)
//    }
