//
//  SearchView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import SwiftUI

struct SearchView: View {
    @StateObject var vm = SearchVM()
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            TextField("Search a movie", text: $vm.searchText)
                .font(.title2)
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.1), .black.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(10)
  
                .onChange(of: vm.searchText) {
                        vm.loadSearches()
                }

            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: layout) {
                    ForEach(vm.searchMovies){ movie in
                        VStack(alignment: .leading) {
                            MovieCard(title: movie.title, image: movie.posterPath, id: movie.id)
                                .frame(maxHeight: .infinity, alignment: .top)
                        }
                    }
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.1), .black]), startPoint: .top, endPoint: .bottom)
        )
    }
}

#Preview {
    SearchView()
}
