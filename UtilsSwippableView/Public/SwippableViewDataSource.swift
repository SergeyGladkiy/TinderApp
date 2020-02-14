//
//  SwippableViewDataSource.swift
//  UtilsSwippableView
//
//  Created by Serg on 10.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

public protocol SwippableViewDataSource: class {
    func view(view: UIView, atIndex index: Int )
    func numberOfViews () -> Int
}
