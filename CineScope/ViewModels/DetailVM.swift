//
//  DetailVM.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//
import Foundation
import Combine

final class DetailVM: ObservableObject {
    @Published var details: DetailModel?
    @Published var state: ViewState = .loading

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchDetailsMovie(id: Int) async {
        state = .loading

        do {
            let response: MovieDetailsResponse = try await apiClient.request(.details(id: id))
            self.details = DetailModel(details: response)
            
            state = .loaded
        }
        catch {
            state = .error("Failed to fetch details")
        }
    }
    
    func loadDetails(id: Int) {
        Task {
            await fetchDetailsMovie(id: id)
        }
    }
}
