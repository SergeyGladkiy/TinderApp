//
//  UserPhoto.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct TinderUserPhoto: Decodable {
    let id: String
    let url: String
    let processedFiles: [TinderUserProcessedFiles]
}

struct TinderUserProcessedFiles: Decodable {
    let url: String
    let width: Int
    let height: Int
}
