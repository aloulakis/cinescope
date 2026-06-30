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

        
        
//        //an kapoios mou zitisei ena APIClientProtocol, tha tou dwsw ena APIClient me to token mou
//        container.register(APIClientProtocol.self) { _ in
//            APIClient(token: Secrets.tmdbToken)
//        }
//        
//        //an kapoios mou zitisei homeVM, tha tou dwsw ena APIClientProtocol
//        container.register(HomeVM.self) { resolver in
//            let network = resolver.resolve(APIClientProtocol.self)!
//            return HomeVM(apiClient: network)
//        }
    }
}

