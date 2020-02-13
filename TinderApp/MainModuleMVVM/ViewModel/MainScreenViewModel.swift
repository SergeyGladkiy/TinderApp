//
//  MainScreenViewModel.swift
//  TinderApp
//
//  Created by Serg on 11.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

enum MainScreenViewModelState {
    case initial
    case finishedLoad
}

class MainScreenViewModel {
    
    private let model: InterfaceMainSreenModel
    let state: Observable<MainScreenViewModelState>
    
    init(model: InterfaceMainSreenModel, state: Observable<MainScreenViewModelState>) {
        self.model = model
        self.state = state
    }
}

extension MainScreenViewModel: InterfaceMainScreenViewModel {
    func getTinderData() {
        self.model.getDataFromTinder()
    }
    
    func likeButtonTapped(sNumber: Int, id: String) {
        self.model.sendLike(sNumber: sNumber, id: id)
    }
    
    func dislikeButtonTapped(sNumber: Int, id: String) {
        self.model.sendDislike(sNumber: sNumber, id: id)
    }
    
    
}
