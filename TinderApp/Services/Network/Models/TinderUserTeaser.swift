//
//  UserTeaser.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct TinderUserTeaser: Decodable {
    let type: String?
    let string: String
}

struct UserJob: Decodable {
    let company: CompanyJob?
    let title: TitleJob?
}

struct UserSchool: Decodable {
    let name: String?
}

struct CompanyJob: Decodable {
    let name: String
}

struct TitleJob: Decodable {
    let name: String
}
