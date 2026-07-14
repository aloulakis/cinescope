//
//  FavoritesView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import SwiftUI

struct FavoritesView: View {
    @State private var refreshId = UserStorage.shared.refreshId
    
    let userStorage: UserStorage
    
    init(userStorage: UserStorage) {
        self.userStorage = userStorage
    }

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
                        ForEach(userStorage.getFavorites(), id: \.id) { movie in
                            MovieCard(title: movie.title, image: movie.posterPath, id: movie.id)
                                .frame(maxHeight: .infinity, alignment: .top)
                                .overlay(alignment: .topTrailing) {
                                    Button {
                                        userStorage.toggleFavorite(movie: movie, isFavorite: movie.isFavorite ?? false)
                                        refreshId = UserStorage.shared.refreshId

                                    }label: {
                                        Image(systemName: (movie.isFavorite ?? false) ? "heart.fill" : "heart.circle")
                                            .font(.title2)
                                            .foregroundStyle(.red)
                                    }
                                }
                        }.id(refreshId)
                    }
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [.black, .blue.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                )
            }
            .onAppear {
                refreshId = UUID()
            }
        }
}
