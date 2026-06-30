//
//  TabView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 21/6/26.
//

import SwiftUI
import Swinject

struct HomeTabView: View {
//    @StateObject var vm = DIContainer.shared.container.resolve(HomeVM.self)!
    var body: some View {
        
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Search", systemImage: "magnifyingglass") {
                SearchView()
            }
            Tab("Saved", systemImage: "heart.fill") {
                FavoritesView()
            }
        }
        
        
        .task {
            let client = APIClient.shared
           // await vm.fetchMovies()
            //let client = APIClient(token: Secrets.tmdbToken)
            do {
                let trendingResponse: MovieListResponse = try await client.request(.trending)
                print(trendingResponse.results)
            } catch {
                print ("Error: \(error)")
            }  
        }
    }
}

#Preview {
    HomeTabView()
}



