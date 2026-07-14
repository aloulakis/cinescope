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
    let profilePath: URL?
    
    var body: some View {
        VStack{
            loadImage(path: profilePath)
            
            Text(name ?? "")
                .foregroundStyle(.gray)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width:100)
        }
        .padding(.bottom)
    }
    
    private func loadImage(path: URL?) -> some View {
        KFImage(path)
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
