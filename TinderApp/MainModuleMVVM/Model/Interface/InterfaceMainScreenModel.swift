//
//  InterfaceMainScreenModel.swift
//  TinderApp
//
//  Created by Serg on 11.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol InterfaceMainSreenModel {
    var models: Observable<[MainScreenDataSource]> { get }
    
    func getDataFromTinder()
    func sendAction(sNumber: Int, id: String, state: StateAction)
}
