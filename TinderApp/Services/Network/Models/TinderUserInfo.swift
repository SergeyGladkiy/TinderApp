//
//  UserInfo.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct TinderUserInfo: Decodable {
    let _id: String
    let bio: String
    let birthDate: String
    let name: String
    let photos: [TinderUserPhoto]
    let gender: Int
    let jobs: [UserJob]
    let schools: [UserSchool]
    let city: UserCity?
}

struct UserCity: Decodable {
    let name: String
}
