//
//  DIContainer.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import Foundation

import Swinject


final class DIContainer {
    
    static let shared = DIContainer()
    
    let container = Container()
    
    private init() {
        registerDependencies()
    }
    
    private func registerDependencies() {
        // Services
        container.register(UserStorage.self) { _ in UserStorage.shared }
            .inObjectScope(.container)
        container.register(APIClient.self) { _ in APIClient.shared }
            .inObjectScope(.container)

        // ViewModels
        container.register(HomeVM.self) { r in
            HomeVM(apiClient: r.resolve(APIClient.self)!)
        }
        container.register(DetailVM.self) { r in
            DetailVM(apiClient: r.resolve(APIClient.self)!)
        }
        container.register(CreditsVM.self) { r in
            CreditsVM(apiClient: r.resolve(APIClient.self)!)
        }
        container.register(RecommendationsVM.self) { r in
            RecommendationsVM(apiClient: r.resolve(APIClient.self)!)
        }
        container.register(SearchVM.self) { r in
            SearchVM(apiClient: r.resolve(APIClient.self)!)
        }

        // Views
        container.register(HomeView.self) { r in
            HomeView(vm: r.resolve(HomeVM.self)!, userStorage: r.resolve(UserStorage.self)!)
        }
        container.register(SearchView.self) { r in
            SearchView(vm: r.resolve(SearchVM.self)!)
        }
        container.register(FavoritesView.self) { r in
            FavoritesView(userStorage: r.resolve(UserStorage.self)!)
        }
        container.register(HomeTabView.self) { r in
            HomeTabView(
                homeView: r.resolve(HomeView.self)!,
                searchView: r.resolve(SearchView.self)!,
                favoritesView: r.resolve(FavoritesView.self)!
            )
        }
        container.register(DetailView.self) { (r, id: Int) in
            DetailView(vm: r.resolve(DetailVM.self)!, id: id, userStorage: r.resolve(UserStorage.self)!)
        }
        container.register(CreditsView.self) { (r, id: Int) in
            CreditsView(vm: r.resolve(CreditsVM.self)!, id: id)
        }
        container.register(RecommendationsView.self) { (r, id: Int) in
            RecommendationsView(vm: r.resolve(RecommendationsVM.self)!, id: id)
        }
    }
}

