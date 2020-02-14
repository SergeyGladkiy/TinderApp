//
//  GotTinderResponse.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct TinderResponseWrapped: Decodable {
    let data: DataTinder
}

struct DataTinder: Decodable {
    let results: [TinderUserResult]
}
