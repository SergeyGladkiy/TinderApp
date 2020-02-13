//
//  TemporaryContainer.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class TemporaryContainer {
    func assembleModule() -> UIViewController {
        let authService = AuthService()
        let networkeService = NetworkService(authService: authService)
        let dataFetcher = NetworkDataFetcher(networkService: networkeService)
        let mapper = MapperMainScreenModel()
        let model = MainScreenModel(networkService: dataFetcher, mapper: mapper)
        let viewModel = MainScreenViewModel(model: model, state: Observable(observable: .initial))
        let vc = MainScreenViewController(viewModel: viewModel)
        return vc
    }
}
