//
//  SwippableViewDelegate.swift
//  UtilsSwippableView
//
//  Created by Serg on 10.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

public protocol SwippableViewDelegate: class {
    func willSwiped(index: Int, direction: swipeDirection)
}
