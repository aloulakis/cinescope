//
//  MovieCard.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 30/6/26.
//

import SwiftUI
import Kingfisher

struct MovieCard: View {
    let title: String?
    let image: URL?
    let id: Int

    var body: some View {
        NavigationLink(destination: DetailView(id: id)) {
            VStack() {
                KFImage(image)
                    .placeholder {
                        ZStack {
                            Rectangle()
                                .fill(Color(.gray.opacity(0.5)))
                            Image(systemName: "film")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 110, height: 200)


                Text(title ?? "Untitled")
                    .foregroundStyle(.white)
            }
            .frame(width: 110)
        }
    }
}

//#Preview {
//    MovieCard(title: "Fight Club", image: "", id: 550)
//}
