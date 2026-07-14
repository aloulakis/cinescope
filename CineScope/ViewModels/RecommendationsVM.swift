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
    
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    private func fetchRecommendations(id: Int) async {
        state = .loading
        
        do {
            let response: MovieListResponse = try await apiClient.request(.recommendations(id: id))
            self.recommendations = response.results?.map { MovieModel(movie: $0) } ?? []
            
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
