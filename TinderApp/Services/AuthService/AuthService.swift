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
    let value = "dbd072a1-7049-449c-a106-aa2d16b64894"
}

extension AuthService: InterfaceAuthService {
    var keyToken: String {
        return key
    }
    
    var valueToken: String {
        return value
    }
    
    
}
