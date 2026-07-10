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
    }
}

#Preview {
    HomeTabView()
}



