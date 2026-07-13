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

    func fetchSearchMovie(page: Int) async {
        state = .loading
        
        do {
            let response: MovieListResponse = try await APIClient.shared.request(.search(query: searchText, page: page))
            
            let pageResult = MoviePage(response: response)
            let movies = pageResult.results?.map { MovieModel(movie: $0) } ?? []
            
            if page == 1 {
                searchMovies = movies
            } else {
                searchMovies += movies
            }
            
            self.totalPages = pageResult.totalPages ?? 1
            self.currentPage = page
            
            state = .loaded
        }
        catch {
            state = .error("Failed to search movies")
        }
    }
    
    func loadSearches(page: Int) {
        Task{
            await fetchSearchMovie(page: page)
        }
    }
    
    func loadNextPage() {
        guard currentPage < totalPages else {return}
        loadSearches(page: currentPage + 1)
    }
}
