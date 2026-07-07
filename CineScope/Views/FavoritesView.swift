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
            ScrollView(.vertical, showsIndicators: false) {
                Text("Favorites")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .padding(.bottom)
                LazyVGrid(columns: layout){
                    ForEach(vm.favorites, id: \.id) { movie in
                        MovieCard(title: movie.title, image: movie.posterPath, id: movie.id)
                            .frame(maxHeight: .infinity, alignment: .top)
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
                //.frame(maxHeight: .infinity, alignment: .top)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.black, .gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
            )

        }
    }
}

//#Preview {
//    FavoritesView()
//}
