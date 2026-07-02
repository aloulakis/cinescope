//
//  FavoritesVM.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import Foundation
import Combine


class FavoritesVM: ObservableObject {
    @Published var favorites: [MovieModel] = []
        
    init () {
        load()
    }
    
    func add(movie: MovieModel) {
        if favorites.contains(where: { $0.id == movie.id }) { return }
        favorites.append(movie)
        
    }
    
    func remove(movie: MovieModel) {
        favorites.removeAll(where: { $0.id == movie.id })
    }
    
    func isFavorite(id: Int) -> Bool {
        favorites.contains(where: { $0.id == id })
    }
    
    func toggleFavorite(movie: MovieModel) {
        if isFavorite(id: movie.id) {
            remove(movie: movie)
            save()
        } else {
            add(movie: movie)
            save()
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(self.favorites) {
            UserDefaults.standard.set(encoded, forKey: "MovieId")
        }
    }
    func load() {
        if let decodedItems = UserDefaults.standard.data(forKey: "MovieId") {
            if let decoded = try? JSONDecoder().decode([MovieModel].self, from: decodedItems) {
                favorites = decoded
            }
        }
    }
}
