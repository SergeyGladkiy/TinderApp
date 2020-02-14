//
//  DependenceProvider.swift
//  TinderApp
//
//  Created by Serg on 14.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class DependenceProvider {
    private static let assembler = Assembler([AuthServiceAssambly(), NetworkServiceAssembly(), CoordinatorAppAssembly(), MainScreenAssembly()])
    
    static func resolve<T>() -> T {
        return assembler.resolver.resolve(T.self)!
    }
}
