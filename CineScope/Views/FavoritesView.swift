//
//  FavoritesView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var vm: FavoritesVM
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout){
                    ForEach(vm.favorites) { movie in
                        MovieCard(title: movie.title, image: movie.posterPath, id: movie.id)
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    vm.toggleFavorite(movie: movie)
                                }label: {
                                    Image(systemName: vm.isFavorite(id: movie.id) ? "heart.fill" : "heart.circle")
                                        .font(.title2)
                                        .foregroundStyle(.red)
                                }
                            }
                    }
                }
            }
            .background((
                LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.1), .black]), startPoint: .top, endPoint: .bottom)
            ))
            .navigationTitle("Favorites")
        }
    }
}

//#Preview {
//    FavoritesView()
//}
