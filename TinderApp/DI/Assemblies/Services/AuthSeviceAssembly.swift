//
//  AuthSeviceAssambly.swift
//  TinderApp
//
//  Created by Serg on 14.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

final class AuthServiceAssambly: Assembly {
    func assemble(container: Container) {
        container.register(InterfaceAuthService.self) { _ in
            AuthService()
        }.inObjectScope(.container)
    }
}
