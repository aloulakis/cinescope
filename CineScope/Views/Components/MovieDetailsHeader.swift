//
//  MovieDetailsSection.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 30/6/26.
//

import SwiftUI
import Kingfisher


struct MovieDetailsHeader: View {
    let detail: DetailModel
    @EnvironmentObject var favoritesVM: FavoritesVM

    var body: some View {
        ZStack {
            KFImage(URL(string: "https://image.tmdb.org/t/p/w780/\(detail.backDropPath ?? "")"))
            //loadImage(path: "\(detail.backDropPath)", width: 400, height: 400, size: "w780")
                .resizable()
                .opacity(0.2)
            
            HStack(spacing: 30) {
                loadImage(path: "\(detail.posterPath ?? "")", width: 140, height: 200, size: "w342")
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
                    favoritesVM.toggleFavorite(movie: MovieModel(details: detail))
                }label: {
                    
                    Image(systemName: favoritesVM.isFavorite(id: detail.id) ? "heart.fill" : "heart.circle")
                        .font(.title)
                        .foregroundStyle(.red)
                        
                }
                .padding(.trailing, 12)
            }
        }
    }
    
    private func loadImage(path: String, width: Int, height: Int, size: String) -> some View {
        KFImage(URL(string:"https://image.tmdb.org/t/p/\(size)/\(path)"))
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(width: CGFloat(width), height: CGFloat(height))
    }
}

//#Preview {
//    MovieDetailsSection()
//}
