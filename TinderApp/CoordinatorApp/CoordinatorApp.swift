//
//  CoordinatorApp.swift
//  TinderApp
//
//  Created by Serg on 11.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class CoordinatorApp {
    private var window: UIWindow?
}

extension CoordinatorApp: InterfaceCoordinator {
    func start() -> UIWindow {
        
        let vc = TemporaryContainer().assembleModule()
        self.window = UIWindow()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return window!
    }
    
}
