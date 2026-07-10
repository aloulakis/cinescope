//
//  HomeView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject var vm = HomeVM()
    @State private var favorites: [MovieModel] = FavoritesStorage.shared.favorites

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
                .onAppear {
                    favorites = FavoritesStorage.shared.favorites
                }
            }
        }
    }
    
    private func featuredMovie(path: String?, id: Int?) -> some View {
        NavigationLink(destination: DetailView(id: id ?? 0)) {
            ZStack(alignment: .topLeading){
                loadImage(path: path ?? "", size: "w780", aspectRatio: 16/9)
                
                loadImage(path: vm.trending.first?.posterPath ?? "", size: "w342", aspectRatio: 2/3)
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
    
    private func loadImage(path: String, size: String, aspectRatio: CGFloat) -> some View {
        KFImage(URL(string:"https://image.tmdb.org/t/p/\(size)/\(path)"))
            .placeholder {
                ZStack {
                    Rectangle()
                        .fill(Color(.gray.opacity(0.5)))
                    Image(systemName: "film")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                }
            }
            .resizable()
            .scaledToFit()
            //.aspectRatio(aspectRatio, contentMode: .fit)
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
                                    FavoritesStorage.shared.toggleFavorite(movie: item)
                                    favorites = FavoritesStorage.shared.favorites
                                }label: {
                                    Image(systemName: favorites.contains(where: { $0.id == item.id }) ? "heart.fill" : "heart.circle")
                                        .font(.title2)
                                        .foregroundStyle(.red)
                                }
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
