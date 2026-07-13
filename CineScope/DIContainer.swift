//
//  DIContainer.swift
//  CineScope
//
//  Created by Alexandros Loulakis on 19/6/26.
//

import Foundation

import Swinject


final class DIContainer {
    
    static let shared = DIContainer()
    
    let container = Container()
    
    private init() {
        registerDependencies()
    }
    
    private func registerDependencies() {
        
    }
}

