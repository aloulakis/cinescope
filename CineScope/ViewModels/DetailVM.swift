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
    
    func fetchDetailsMovie(id: Int) async {
        state = .loading
        
        do {
            let response: MovieDetailsResponse = try await APIClient.shared.request(.details(id: id))
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




//final class DetailVM: ObservableObject {
//
//    @Published var details: DetailModel?
//
//
//    @Published var state: ViewState = .idle
//
//
//    func fetchDetailsMovie(id: Int) async {
//        state = .loading
//
//
//
//        if let data = await self.getDetails(id: id) {
//            self.details = DetailModel(details: data)
//            state = .loaded
//        } else {
//            state = .error("Can't fetch details")
//        }
//
//
//    }
//    private func getDetails(id: Int) async -> MovieDetailsResponse? {
//        do {
//            return try await APIClient.shared.request(.details(id: id))
//        }
//        catch {
//            return nil
//        }
//    }
//}
