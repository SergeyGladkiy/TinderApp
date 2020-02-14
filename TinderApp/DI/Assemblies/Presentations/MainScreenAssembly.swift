//
//  MainScreenAssembly.swift
//  TinderApp
//
//  Created by Serg on 14.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

final class MainScreenAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MainScreenViewController.self) { r in
            let viewModel = r.resolve(InterfaceMainScreenViewModel.self)!
            return MainScreenViewController(viewModel: viewModel)
        }
        
        container.register(InterfaceMainScreenViewModel.self) { r in
            let model = r.resolve(InterfaceMainSreenModel.self)!
            return MainScreenViewModel(model: model, state: Observable(observable: .initial))
        }
        
        container.register(InterfaceMainSreenModel.self) { r in
            let mapper = r.resolve(InterfaceMapperMainScreenModel.self)!
            let networkService = r.resolve(InterfaceDataFetcher.self)!
            return MainScreenModel(networkService: networkService, mapper: mapper)
        }
        
        container.register(InterfaceMapperMainScreenModel.self) { _ in
            MapperMainScreenModel()
        }
    }
}
