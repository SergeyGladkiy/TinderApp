//
//  NetworkServiceAssambly.swift
//  TinderApp
//
//  Created by Serg on 14.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

final class NetworkServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(InterfaceDataFetcher.self) { r in
            let networkService = r.resolve(InterfaceNetworkService.self)!
            return NetworkDataFetcher(networkService: networkService)
        }.inObjectScope(.container)
        
        container.register(InterfaceNetworkService.self) { r in
            let authService = r.resolve(InterfaceAuthService.self)!
            return NetworkService(authService: authService)
        }
    }
    
}
