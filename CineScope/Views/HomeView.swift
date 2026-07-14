//
//  HomeView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//
import SwiftUI
import Kingfisher
import Swinject

struct HomeView: View {
    @StateObject var vm: HomeVM
    @State private var refreshId = UserStorage.shared.refreshId
    
    let userStorage: UserStorage
    
    init(vm: HomeVM, userStorage: UserStorage) {
        _vm = StateObject(wrappedValue: vm)
        self.userStorage = userStorage
    }

    var sections: [(title: String, movies: [MovieModel])] {
        [
            ("Trending", vm.trending),
            ("Popular", vm.popular),
            ("Top Rated", vm.topRated),
            ("Upcoming", vm.upcoming)
        ]
    }

    var body: some View {
        NavigationView {
            switch vm.state {
            case .loading:
                ProgressView()
                    .onAppear {
                        vm.loadData()
                    }
            case .error(let error):
                Text(error)
            case .loaded:
                ScrollView(.vertical, showsIndicators: false) {
                    Text("CineScope")
                        .foregroundStyle(
                            LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .padding(.bottom)
                    
                    featuredMovie(path: vm.trending.first?.backdropPath,
                                  id: vm.trending.first?.id)
                        .padding(.bottom)
                    
                    VStack(spacing: 4) {
                        ForEach(sections, id: \.title) { section in
                            movieSection(title: section.title, movies: section.movies)
                        }
                    }
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [.black, .blue.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                )
            }
        }
    }
    
    private func featuredMovie(path: URL?, id: Int?) -> some View {
        NavigationLink(destination: DIContainer.shared.container.resolve(DetailView.self, argument: id ?? 0)!) {
            ZStack(alignment: .topLeading){
                loadImage(path: path)
                
                loadImage(path: vm.trending.first?.posterPath,)
                    .frame(width: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                .blue.opacity(0.4),
                                lineWidth: 3)
                    )
                    .padding(.leading, 8)
            }
        }
    }
    
    private func loadImage(path: URL?) -> some View {
        KFImage(path)
            .placeholder {
                ZStack {
                    Rectangle()
                        .fill(.gray.opacity(0.5))
                    Image(systemName: "film")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                }
            }
            .resizable()
            .scaledToFit()
    }

    private func movieSection(title: String, movies: [MovieModel]) -> some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)

                Spacer()

                Button("See all") {}
                    .foregroundStyle(.blue)
                    .padding(.trailing)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(movies) { item in
                        MovieCard(title: item.title, image: item.posterPath, id: item.id)
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    let isFav = UserStorage.shared.getFavorites().contains(where: { $0.id == item.id })
                                    UserStorage.shared.toggleFavorite(movie: item, isFavorite: isFav)
                                    refreshId = UserStorage.shared.refreshId
                                }label: {
                                    Image(systemName: UserStorage.shared.getFavorites().contains(where: { $0.id == item.id }) ? "heart.fill" : "heart.circle")
                                        .font(.title2)
                                        .foregroundStyle(.red)
                                }
                            }
                    }
                }
            }
        }
        .id(refreshId)
        .onAppear {
            refreshId = UUID()
        }
    }
}
