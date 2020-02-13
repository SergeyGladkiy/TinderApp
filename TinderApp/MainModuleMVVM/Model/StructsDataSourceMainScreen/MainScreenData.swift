//
//  MainScreenData.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct MainScreenDataSource {
    let userInfo: UserInfo
    let distance: Int
    let sNumber: Int
}

struct UserInfo {
    let id: String
    let bio: String
    let birthDate: String
    let name: String
    let photos: [UserPhoto]
    let gender: Int
    let jobs: String
    let schools: String
    let city: String
}

struct UserPhoto {
    let id: String
    let url: String
    let processedFiles: [UserProcessedFiles]
}

struct UserProcessedFiles {
    let url: String
    let width: Int
    let height: Int
}
