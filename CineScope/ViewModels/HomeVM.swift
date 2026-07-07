//
//  HomeVM.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//
import Foundation
import Combine

final class HomeVM: ObservableObject {
    @Published var trending: [MovieModel] = []
    @Published var popular: [MovieModel] = []
    @Published var topRated: [MovieModel] = []
    @Published var upcoming: [MovieModel] = []
    
    @Published var state: ViewState = .loading
    
    init() { }

    func fetchMovies() async {
        await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                let data = await self.getTrending()

                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.trending = makeMovieModel(from: data)
                }
            }
            group.addTask {
                let data = await self.getPopular()
  
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.popular = makeMovieModel(from: data)
                }
            }
            group.addTask {
                let data = await self.getTopRated()
     
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.topRated = makeMovieModel(from: data)
                }
            }
            group.addTask {
                let data = await self.upcoming()

                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.upcoming = makeMovieModel(from: data)
                }
            }
        }
        
        if trending.isEmpty, popular.isEmpty, popular.isEmpty, upcoming.isEmpty {
            state = .error("Failed to fetch movies")
        } else {
            state = .loaded
        }
    }
    
    func loadData() {
        Task {
            await fetchMovies()
        }
    }
    
    private func getTrending() async -> MovieListResponse? {
        do {
            return try await APIClient.shared.request(.trending)
        }
        catch {
            return nil
        }
    }
    
    private func getPopular() async -> MovieListResponse? {
        do {
            return try await APIClient.shared.request(.popular)
        }
        catch {
            return nil
        }
    }
    
    private func getTopRated() async -> MovieListResponse? {
        do {
            return try await APIClient.shared.request(.topRated)
        }
        catch {
            return nil
        }
    }
    
    private func upcoming() async -> MovieListResponse? {
        do {
            return try await APIClient.shared.request(.upComing)
        }
        catch {
            return nil
        }
    }

    private func makeMovieModel(from: MovieListResponse?) -> [MovieModel] {
        return (from?.results ?? []).map { movie in
            MovieModel(movie: movie)
        }
    }
}

