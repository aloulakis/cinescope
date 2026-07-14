//
//  CreditsVM.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 29/6/26.
//
import Foundation
import Combine

final class CreditsVM: ObservableObject {
    @Published var cast: [CastModel] = []
    @Published var crew: [CrewModel] = []
    @Published var state: ViewState = .loading
    
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    private func fetchCredits(id: Int) async {
        state = .loading
        do {
            let response: CreditsResponse = try await apiClient.request(.credits(id: id))
            self.cast = (response.cast ?? []).map { CastModel(cast: $0) }
            self.crew = (response.crew ?? []).map { CrewModel(crew: $0) }

            state = .loaded
        }
        catch {
            state = .error("Cant fetch credits")
        }
    }
    
    func loadCredits(id: Int) {
        Task { await fetchCredits(id: id) }
    }
}
