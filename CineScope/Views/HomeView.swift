//
//  HomeView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeVM()

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
                    VStack(spacing: 4) {
                        ForEach(sections, id: \.title) { section in
                            movieSection(title: section.title, movies: section.movies)
                        }
                    }
                    .padding(.horizontal)
                }
                .background(.black.opacity(0.9))
            }
        }
    }

    private func movieSection(title: String, movies: [MovieModel]) -> some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(
                        LinearGradient(gradient: Gradient(colors: [.blue, .gray.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                    )
                    .padding(.horizontal, 6)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.red, .gray.opacity(0.1)]), startPoint: .trailing, endPoint: .leading)
                    )
                    .clipShape(Capsule())

                Spacer()

                Button("See all") {}
                    .foregroundStyle(.blue)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(movies) { item in
                        MovieCard(title: item.title, image: item.posterPath, id: item.id)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
