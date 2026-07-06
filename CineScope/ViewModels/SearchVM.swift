//
//  SearchVM.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import Foundation
import Combine

@MainActor
final class SearchVM: ObservableObject {
    
    @Published var searchMovies: [MovieModel] = []
    @Published var searchText: String = ""
    @Published var state: ViewState = .loading


    func fetchSearchMovie() async {
        state = .loading
        
        do {
            let response: MovieListResponse = try await APIClient.shared.request(.search(query: searchText))
            self.searchMovies = response.results.map{MovieModel(movie: $0)}
            
            state = .loaded
        }
        catch {
            state = .error("Failed to search movies")
        }
    }
    
    func loadSearches() {
        Task{
            await fetchSearchMovie()
        }
    }
    
}
