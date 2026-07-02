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
        VStack(alignment: .leading, spacing: 10) {
            Text("Cast")
                .foregroundStyle(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    HStack(alignment: .top, spacing: 13){
                        ForEach(vm.cast, id: \.id) { cast in
                            CastCard(name: cast.name, profilePath: cast.profilePath)
                        }
                    }
                }
            }
            .padding()
            .onAppear() {
                vm.loadCredits(id: id)
            }
        }
    }
}

#Preview {
    CreditsView(id: 550)
}

