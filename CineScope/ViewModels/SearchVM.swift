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
    
    private var currentPage = 1
    private var totalPages = 1

    func fetchSearchMovie(currentPage: Int) async {
        state = .loading
        
        do {
            let response: MovieListResponse = try await APIClient.shared.request(.search(query: searchText, page: currentPage))

            if currentPage == 1 {
                searchMovies = response.results.map { MovieModel(movie: $0) }
            } else {
                print(searchMovies, "--------------------------------------")
                searchMovies += response.results.map { MovieModel(movie: $0) }
                
            }
            self.totalPages = response.totalPages
            self.currentPage = currentPage
            
            state = .loaded
        }
        catch {
            state = .error("Failed to search movies")
        }
    }
    
    func loadSearches(page: Int) {
        Task{
            await fetchSearchMovie(currentPage: page)
        }
    }
    
    func loadNextPage() {
        guard currentPage < totalPages else {return}
        loadSearches(page: currentPage + 1)
    }
    
}
