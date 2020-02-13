//
//  UserResult.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct TinderUserResult: Decodable {
    let user: TinderUserInfo
    let distanceMi: Int
    let teaser: TinderUserTeaser
    let teasers: [TinderUserTeaser]
    let sNumber: Int
}
