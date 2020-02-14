//
//  InterfaceNetworkService.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol InterfaceNetworkService {
    func request(path: String, paramse: [String: String]?, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}
