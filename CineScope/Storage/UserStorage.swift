//
//  FavoritesStorage.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 9/7/26.
//
import Foundation

final class UserStorage {
    
    static let shared = UserStorage()

    private(set) var favorites: [MovieModel] = []
    private(set) var refreshId = UUID()
    
    init () {
        load()
    }
    
    func getFavorites() -> [MovieModel] {
        favorites
    }
    
    func add(movie: MovieModel) {
        if favorites.contains(where: { $0.id == movie.id }) { return }
        var favoriteMovie = movie
        favoriteMovie.isFavorite = true
        favorites.append(favoriteMovie)
    }
    
    func remove(movie: MovieModel) {
        favorites.removeAll(where: { $0.id == movie.id })
    }
    
    func isFavorite(id: Int) -> Bool {
        favorites.contains(where: { $0.id == id })
    }
    
    func toggleFavorite(movie: MovieModel, isFavorite: Bool) {
        if  isFavorite {
            remove(movie: movie)
            save()
        } else {
            add(movie: movie)
            save()
        }
        refreshId = UUID()
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
