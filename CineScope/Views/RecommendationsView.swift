//
//  Recommendations.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 29/6/26.
//

import SwiftUI

struct RecommendationsView: View {
    @StateObject var vm = RecommendationsVM()
    let id: Int
    
    var body: some View {
        
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

#Preview {
    RecommendationsView(id: 550)
}
