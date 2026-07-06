//
//  SearchView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import SwiftUI

struct SearchView: View {
    @StateObject var vm = SearchVM()
    
    var body: some View {
        VStack {
            TextField("Search a movie", text: $vm.searchText)
                
                //.background(.gray.opacity(0.6))
                
                
                
            Button("Search") {
                vm.loadSearches()
                
            }
            
            
            ScrollView {
                ForEach(vm.searchMovies){ movie in
                    VStack(alignment: .leading) {
                        MovieCard(title: movie.title, image: movie.posterPath, id: movie.id)
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
