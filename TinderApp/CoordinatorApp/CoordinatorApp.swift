//
//  CoordinatorApp.swift
//  TinderApp
//
//  Created by Serg on 11.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class CoordinatorApp {
    private var window: UIWindow?
}

extension CoordinatorApp: InterfaceCoordinatorApp {
    func start() -> UIWindow {
        
        let vc: MainScreenViewController = DependenceProvider.resolve()
        self.window = UIWindow()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return window!
    }
    
}
