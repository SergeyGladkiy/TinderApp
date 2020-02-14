//
//  InterfaceDataFetcher.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol InterfaceDataFetcher {
    func getData(response: @escaping (DataTinder?) -> Void)
    
    func postEventAction(_idUser: String, sNumberUser: Int, action: StateAction)
}
