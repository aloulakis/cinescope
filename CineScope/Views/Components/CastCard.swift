//
//  CastCard.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 30/6/26.
//

import SwiftUI
import Kingfisher
struct CastCard: View {
    let name: String?
    let profilePath: String?
    
    var body: some View {
        VStack{
            loadImage(path: profilePath ?? "")
                //.frame(width: 100)
            
            Text(name ?? "")
                .foregroundStyle(.gray)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width:100)
        }
        .padding(.bottom)
        //.background(.yellow)
        //.frame(width: 100)
    }
    
    private func loadImage(path: String) -> some View {
        KFImage(URL(string:"https://image.tmdb.org/t/p/w342/\(path)"))
            .placeholder {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundStyle(.gray)
            }
            .resizable()
            .clipShape(Capsule())
            .frame(width: 100, height: 100)
    }
}

//#Preview {
//    CastCard()
//}
