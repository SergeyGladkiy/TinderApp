//
//  MainScreenViewModel.swift
//  TinderApp
//
//  Created by Serg on 11.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

enum StateAction {
    case plus
    case minus
}

enum MainScreenViewModelState {
    case initial
    case finishedLoad
}

class MainScreenViewModel {
    
    private let model: InterfaceMainSreenModel
    let state: Observable<MainScreenViewModelState>
    var dataSource = Observable(observable: [MainScreenDataSource]())
    
    init(model: InterfaceMainSreenModel, state: Observable<MainScreenViewModelState>) {
        self.model = model
        self.state = state
        
        model.models.bind { [weak self] data in
            guard let self = self else { return }
            if data.isEmpty { return }
            
            self.dataSource.observable = data
            self.state.observable = .finishedLoad
        }
        
    }
}

extension MainScreenViewModel: InterfaceMainScreenViewModel {
    
    func getTinderData() {
        self.model.getDataFromTinder()
    }
    
    func actionbuttonTapped(index: Int, action: StateAction) {
        let infoModel = dataSource.observable[index]
        self.model.sendAction(sNumber: infoModel.sNumber, id: infoModel.userInfo.id, state: action)
       }
}
