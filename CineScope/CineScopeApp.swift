//
//  CineScopeApp.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import SwiftUI
import Swinject

@main
struct CineScopeApp: App {
    var body: some Scene {
        WindowGroup {
            DIContainer.shared.container.resolve(HomeTabView.self)!
        }
    }
}
