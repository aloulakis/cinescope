//
//  CineScopeApp.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import SwiftUI

@main
struct CineScopeApp: App {
//    init() {
//        APIClient.shared.getToken(token: Secrets.tmdbToken)
//    }
    
    //let apiClient = APIClient(token: Secrets.tmdbToken)
    
    var body: some Scene {
        WindowGroup {
            HomeTabView()
        }
    }
}
