//
//  MainScreenModel.swift
//  TinderApp
//
//  Created by Serg on 11.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class MainScreenModel {
    private let networkService: InterfaceDataFetcher
    private let mapper: InterfaceMapperMainScreenModel
    var models: Observable<[MainScreenDataSource]> = Observable(observable: [])
    
    init(networkService: InterfaceDataFetcher, mapper: InterfaceMapperMainScreenModel) {
        self.networkService = networkService
        self.mapper = mapper
    }
}

extension MainScreenModel: InterfaceMainSreenModel {
    func getDataFromTinder() {
        networkService.getData { [weak self] (response) in
            guard let self = self, let response = response else { return }
            self.models.observable = self.mapper.getDataSource(from: response)
        }
    }
    
    func sendAction(sNumber: Int, id: String, state: StateAction) {
        networkService.postEventAction(_idUser: id, sNumberUser: sNumber, action: state)
    }
}
