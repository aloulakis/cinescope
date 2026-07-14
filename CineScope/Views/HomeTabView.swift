//
//  TabView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 21/6/26.
//
import SwiftUI
import Swinject

struct HomeTabView: View {
    let homeView: HomeView
    let searchView: SearchView
    let favoritesView: FavoritesView

    var body: some View {
        TabView {
            homeView
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            searchView
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            favoritesView
                .tabItem {
                    Label("Saved", systemImage: "heart.square")
                }
        }
    }
}



