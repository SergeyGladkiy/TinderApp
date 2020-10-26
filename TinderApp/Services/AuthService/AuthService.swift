//
//  AuthService.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class AuthService {
    let key = "X-Auth-Token"
    let value = "f9fd3ab8-1a26-4806-8c35-29bd1b729583"
}

extension AuthService: InterfaceAuthService {
    var keyToken: String {
        return key
    }
    
    var valueToken: String {
        return value
    }
    
    
}
