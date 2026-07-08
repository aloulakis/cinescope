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
                    Text("CineScope")
                        .foregroundStyle(
                            LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
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
