//
//  MovieCard.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 30/6/26.
//

import SwiftUI
import Kingfisher

struct MovieCard: View {
    let title: String
    let image: String
    let id: Int

    var body: some View {
        NavigationLink(destination: DetailView(id: id)) {
            VStack {
                KFImage(URL(string: "https://image.tmdb.org/t/p/w342/\(image)"))
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 110, height: 200)

                Text(title)
                    .foregroundStyle(.white)
            }
            .frame(width: 110)
        }
    }
}

#Preview {
    MovieCard(title: "Fight Club", image: "", id: 550)
}
