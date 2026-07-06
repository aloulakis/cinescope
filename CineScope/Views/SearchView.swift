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
        
        TextField("Search a movie", text: $vm.searchText)
            .padding()
        Button("Search") {
            Task{
                await vm.fetchSearchMovie()
            }
        }
        ForEach(vm.searchMovies){ movie in
            VStack(alignment: .leading) {
                MovieCard(title: movie.title, image: movie.posterPath, id: movie.id)
            }
        }
    }
}


#Preview {
    SearchView()
}
