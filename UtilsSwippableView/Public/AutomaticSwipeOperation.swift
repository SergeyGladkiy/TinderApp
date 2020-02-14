//
//  AutomaticSwipeOperation.swift
//  UtilsSwippableView
//
//  Created by Serg on 10.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class AutomaticSwipeOperation: Operation {
    var direction: swipeDirection
    var superview: SwippableView!
    var success: () -> ()
    var view: UIView!
    
    init(direction: swipeDirection, superview: SwippableView, success: @escaping ()-> ()) {
        self.success = success
        self.direction = direction
        super.init()
        self.superview = superview
        
    }
    
    override func main() {
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.main.async {
            
            self.view = self.superview.subviews.last
            let newCenter = self.direction == .left ? CGPoint(x: self.view.center.x - 500 , y: self.view.center.y) : CGPoint(x: self.view.center.x + 500 , y: self.view.center.y)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.view.center = newCenter
                let centerDiff = self.view.center.x - self.superview.bounds.width / 2
                let rotator = self.superview.bounds.width / 2 / 0.3
                self.view.transform = CGAffineTransform(rotationAngle: centerDiff / rotator)
            }) { (finished) in
                
                if finished
                {
                    self.superview.handleAction(view: self.view, direction: self.direction)
                    self.success()
                    semaphore.signal()
                    
                }
            }
        }
        
        
        _ = semaphore.wait(timeout: .distantFuture)
        
    }
}
