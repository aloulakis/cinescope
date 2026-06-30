//
//  DetailView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    
    @StateObject var vm = DetailVM()
    
    @State var isExpanded: Bool = false
    let id: Int
    
    var body: some View {
        switch vm.state {
        case.loading:
            ProgressView()
                .onAppear {
                    vm.loadDetails(id: id)
                }
        case .loaded:
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if let details = vm.details {
                        movieDetails(details)
                    }
                }
                .padding(.bottom,90) // xwros sto telos wste na min kruvetai to teleutaio stoixeio
            }
            .ignoresSafeArea()
            .background(.black.opacity(0.8))
            
        case.error(let error):
            Text(error)
        }
    }
    
    private func movieDetails (_ detail: DetailModel ) -> some View {
        
        VStack(alignment: .leading, spacing: 13) {
            ZStack {
                Button (action: {
                    print("Button is tapped")
                })
                {
                    Image(systemName: "heart.fill")
                        //.foregroundStyle(.red)
                        .offset(x: 180, y: -100)
                }
                
                KFImage(URL(string: "https://image.tmdb.org/t/p/w780/\(detail.backDropPath)"))
                //loadImage(path: "\(detail.backDropPath)", width: 400, height: 400, size: "w780")
                    .resizable()
                    .opacity(0.2)
                    
                HStack(spacing: 30) {
                    loadImage(path: "\(detail.posterPath)", width: 140, height: 200, size: "w342")
                        .opacity(0.6)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(detail.title)
                            .font(.title)
                        if let collection = detail.belongsToCollection, let name = collection.name {
                            Text(name)
                        }
                        
                        Text("\(detail.formattedDate) · \(detail.formattedRunTime)")
                        HStack {
                            Text("\(Image(systemName: "star.fill"))")
                                .foregroundColor(.yellow)
        
                            Text("\(detail.voteAverage)")
                        }
                    }
                    .padding(.bottom)
                    .foregroundStyle(.white)
                    
                }
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            genreSection(detail.genres)
            
            
            
            Text(detail.overview)
                .foregroundStyle(.white)
                .padding(.leading)
                .font(.system(.body, design: .rounded))
                .lineLimit(isExpanded ? nil : 2)
            
            Button(isExpanded ? "Show less" : "Show more") {
                isExpanded.toggle()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Cast")
                .foregroundStyle(.white)
            
            CreditsView(id: detail.id)
            
            Text("More like this")
                .foregroundStyle(.white)
            
            RecommendationsView(id: detail.id)
        }
        .font(.system(.body, design: .serif))
    }
    
    private func loadImage(path: String, width: Int, height: Int, size: String) -> some View {
        KFImage(URL(string:"https://image.tmdb.org/t/p/\(size)/\(path)"))
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(width: CGFloat(width), height: CGFloat(height))
    }
    
    private func genreSection(_ genres: [Genre]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres, id: \.id) { gen in
                    Text(gen.name ?? "")
                        .foregroundStyle(.white)
                        .frame(height: 30)
                        .padding(.horizontal, 10)
                        .background(.gray)
                        .clipShape(Capsule())
                }
            }
            .padding(.leading)
        }
    }
}

#Preview {
    DetailView(id: 500)
}
