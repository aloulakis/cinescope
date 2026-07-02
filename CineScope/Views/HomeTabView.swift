//
//  TabView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 21/6/26.
//

import SwiftUI
import Swinject

struct HomeTabView: View {
    @StateObject var favoritesVM = DIContainer.shared.container.resolve(FavoritesVM.self)!
    
    
    var body: some View {
        
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Search", systemImage: "magnifyingglass") {
                SearchView()
            }
            Tab("Saved", systemImage: "heart.square") {
                FavoritesView()
            }
        }
        .environmentObject(favoritesVM)
    }
}

#Preview {
    HomeTabView()
}



