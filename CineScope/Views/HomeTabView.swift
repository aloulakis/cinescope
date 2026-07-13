//
//  TabView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 21/6/26.
//
import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            FavoritesView()
                .tabItem {
                    Label("Saved", systemImage: "heart.square")
                }
        }
    }
}

#Preview {
    HomeTabView()
}



