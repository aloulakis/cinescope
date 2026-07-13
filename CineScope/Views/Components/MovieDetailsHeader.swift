//
//  MovieDetailsSection.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 30/6/26.
//

import SwiftUI
import Kingfisher
import Swinject

struct MovieDetailsHeader: View {
    let detail: DetailModel
    @State private var isFavorite: Bool = false

    var body: some View {
        ZStack {
            loadImage(path: detail.backdropPath)
                .opacity(0.2)
            
            HStack(spacing: 30) {
                loadImage(path: detail.posterPath)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 140, height: 200)
                    .opacity(0.6)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(detail.title ?? "Untitled")
                        .font(.title)
                    if let collection = detail.belongsToCollection, let name = collection.name {
                        Text(name)
                    }
                    
                    Text("\(detail.formattedDate) · \(detail.formattedRunTime)")
                    HStack {
                        Text("\(Image(systemName: "star.fill"))")
                            .foregroundColor(.yellow)
                        
                        Text("\(detail.voteAverage ?? "")")
                    }
                }
                .padding(.bottom)
                .foregroundStyle(.white)
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .topTrailing) {
                Button {
                    FavoritesStorage.shared.toggleFavorite(movie: MovieModel(details: detail))
                    isFavorite.toggle()
                }label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart.circle")
                        .font(.title)
                        .foregroundStyle(.red)
                        
                }
                .padding(.trailing, 12)
            }
        }
        .onAppear {
            isFavorite = MovieModel(details: detail).isFavorite ?? false
        }
    }
    
    private func loadImage(path: URL?) -> some View {
        KFImage(path)
            .resizable()
    }
}

//#Preview {
//    MovieDetailsSection()
//}
