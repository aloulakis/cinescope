//
//  RecommendationsVM.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 29/6/26.
//
import Foundation
import Combine

final class RecommendationsVM: ObservableObject {
    
    @Published var recommendations: [MovieModel] = []
    
    @Published var state: ViewState = .loading
    
    private func fetchRecommendations(id: Int) async {
        state = .loading
        
        do {
            let response: MovieListResponse = try await APIClient.shared.request(.recommendations(id: id))
            self.recommendations = response.results.map { MovieModel(movie: $0) }
            
            state = .loaded
        } catch {
            state = .error("Failed to fetch recommendations")
            
        }
    }
    
    func loadRecommendations(id: Int) {
        Task {
            await fetchRecommendations(id: id)
        }
    }
}
