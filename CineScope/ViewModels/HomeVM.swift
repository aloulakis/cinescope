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
    //more to come: trending, upcoming,
    
    @Published var state: ViewState = .loading
    
    init() { }
 
    

    func fetchMovies() async {
        var trendingData: MovieListResponse?
        var popularData: MovieListResponse?
        var topRatedData: MovieListResponse?
        var upcomingData: MovieListResponse?
        
        //state = .loading
        await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                let data = await self.getTrending()
                trendingData = data
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.trending = makeMovieModel(from: data)
                }
            }
            group.addTask {
                let data = await self.getPopular()
                popularData = data
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.popular = makeMovieModel(from: data)
                }
            }
            group.addTask {
                let data = await self.getTopRated()
                topRatedData = data
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.topRated = makeMovieModel(from: data)
                }
            }
            group.addTask {
                let data = await self.upcoming()
                upcomingData = data
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.upcoming = makeMovieModel(from: data)
                }
            }
            //grouptasks for toprated, upcoming
            
            
            //try await group.waitForAll() // ola ta task teleiwsan
        }
        if trendingData == nil || popularData == nil || topRatedData == nil || upcomingData == nil {
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
//func fetchMovies() async {
//    var trendingData: MovieListResponse?
//    var popularData: MovieListResponse?
//    var topRatedData: MovieListResponse?
//    var upcomingData: MovieListResponse?
//    
//    //state = .loading
//    
//    do {
//        try await withThrowingTaskGroup(of: Void.self) { group in
//            group.addTask {
//                let data = await self.getTrending()
//                trendingData = data
//            }
//            group.addTask {
//                let data = await self.getPopular()
//                popularData = data
//            }
//            group.addTask {
//                let data = await self.getTopRated()
//                topRatedData = data
//            }
//            group.addTask {
//                let data = await self.upcoming()
//                upcomingData = data
//            }
//            try await group.waitForAll()
//            
//            self.trending = makeMovieModel(from: trendingData)
//            self.popular = makeMovieModel(from: popularData)
//            self.topRated = makeMovieModel(from: topRatedData)
//            self.upcoming = makeMovieModel(from: upcomingData)
//            //grouptasks for toprated, upcoming
//            
//            
//            //try await group.waitForAll() // ola ta task teleiwsan
//        }
//    }
//
//     catch {
//        state = .error("failed")
//    }
//    if trendingData == nil || popularData == nil || topRatedData == nil || upcomingData == nil {
//        state = .error("Failed to fetch movies")
//    } else {
//        state = .loaded
//    }
//}




//
//func fetchMovies() async {
//    state = .loading
//    await withThrowingTaskGroup(of: Void.self) { group in
//       group.addTask {
//           let data = await self.getTrending()
//           DispatchQueue.main.async { [weak self] in
//               guard let self else { return }
//               trending = data
//
//           }
//       }
//       group.addTask {
//           //self.popular = await APIClient.shared.request(.popular)
//           let data = await self.getPopular()
//           DispatchQueue.main.async { [weak self] in
//               guard let self else { return }
//               popular = data
//           }
//       }
//        //try await group.waitForAll()
//        if trending == nil || popular == nil {
//            state = .error("Failed to fetch movies")
//        }
//   }
