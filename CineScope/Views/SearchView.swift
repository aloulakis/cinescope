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
        NavigationView {
            VStack(spacing: 0) {
                Text("Search")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                TextField("", text: $vm.searchText, prompt: Text("Search a movie").foregroundColor(.gray))
                    
                    .font(.title)
                    .font(Font.title.bold())
                    .foregroundColor(.red)
                    .padding()
                    
                    
                
                    .background(.blue.opacity(0.1)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing),
                                lineWidth: 5)
                    )
                    .cornerRadius(10)
                
                    .onChange(of: vm.searchText) {
                        vm.loadSearches(page: 1)
                    }
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layout) {
                        ForEach(vm.searchMovies, id: \.id){ movie in
                            VStack(alignment: .leading) {
                                MovieCard(title: movie.title, image: movie.posterPath, id: movie.id)
                                    .frame(maxHeight: .infinity,  alignment: .top)
                            }
                            .onAppear {
                                if movie.id == vm.searchMovies.last?.id {
                                    vm.loadNextPage()
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.black, .blue.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
            )
        }
    }
}

#Preview {
    SearchView()
}
