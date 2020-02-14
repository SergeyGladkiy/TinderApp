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
    let value = "69c79c81-b37d-4a1a-94bc-6a3691c442f4"
}

extension AuthService: InterfaceAuthService {
    var keyToken: String {
        return key
    }
    
    var valueToken: String {
        return value
    }
    
    
}
