//
//  InterfaceMainScreenViewModel.swift
//  TinderApp
//
//  Created by Serg on 11.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol InterfaceMainScreenViewModel {
    var state: Observable<MainScreenViewModelState> { get }
    var dataSource: Observable<[MainScreenDataSource]> { get }
    
    func getTinderData()
    func actionbuttonTapped(index: Int, action: StateAction)
}
