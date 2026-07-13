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
                .padding(.bottom,90) // Add bottom spacing so the last item isnt hidden
            }
            .ignoresSafeArea()
            .background(
                LinearGradient(gradient: Gradient(colors: [.black, .blue.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
            )
        case.error(let error):
            Text(error)
        }
    }
    
    private func movieDetails (_ detail: DetailModel ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            MovieDetailsHeader(detail: detail)
            overview(detail.overview ?? "")
            genreSection(detail.genres)
            CreditsView(id: detail.id)
            RecommendationsView(id: detail.id)
        }
        .font(.system(.body, design: .serif))
    }
    
    @ViewBuilder
    private func overview(_ detail: String) -> some View {
        Text(detail)
            .foregroundStyle(.white)
            .padding(.leading)
            .font(.system(.body, design: .rounded))
            .lineLimit(isExpanded ? nil : 2)
        
        Button(isExpanded ? "Show less" : "Show more") {
            isExpanded.toggle()
        }
        .frame(maxWidth: .infinity, alignment: .center)
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
