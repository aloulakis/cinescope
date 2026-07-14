//
//  Recommendations.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 29/6/26.
//
import SwiftUI
import Swinject

struct RecommendationsView: View {
    @StateObject var vm: RecommendationsVM
    let id: Int

    init(vm: RecommendationsVM, id: Int) {
        _vm = StateObject(wrappedValue: vm)
        self.id = id
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("More like this")
                .foregroundStyle(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(vm.recommendations) { movie in
                        MovieCard(title: movie.title, image: movie.posterPath, id: movie.id)
                    }
                }
            }
            .onAppear() {
                vm.loadRecommendations(id: id)
            }
        }
    }
}

#Preview {
    DIContainer.shared.container.resolve(RecommendationsView.self, argument: 550)!
}
