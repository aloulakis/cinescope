//
//  CreditsView.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 29/6/26.
//

import SwiftUI
import Kingfisher

struct CreditsView: View {
    @StateObject var vm = CreditsVM()
    let id: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(alignment: .top, spacing: 13){
                ForEach(vm.cast, id: \.id) { cast in
                    VStack{
                        loadImage(path: cast.profilePath)
                            .frame(width: 100)
                        
                        Text(cast.name)
                            .foregroundStyle(.gray)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(width:100)
                    }
                    .padding(.bottom)
                    //.background(.yellow)
                    .frame(width: 100)
                }
            }
        }
        .padding()
        .onAppear() {
            vm.loadCredits(id: id)
        }
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

#Preview {
    CreditsView(id: 550)
}



//HStack {
//    ForEach(vm.cast) { cast in
//        VStack() {
//            loadImage(path: cast.profilePath)
//                
//            Text(cast.name)
//                .foregroundStyle(.gray)
//                .font(.caption)
//                .multilineTextAlignment(.center)
//                .lineLimit(2)
//                .frame(width: 90)
//        }
//        .frame(height: 150)
//    }
//
//}
