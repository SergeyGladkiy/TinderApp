//
//  SwippableView.swift
//  UtilsSwippableView
//
//  Created by Serg on 10.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

public enum swipeDirection {
    case left
    case right
}

public class SwippableView: UIView {
    public weak var dataSource: SwippableViewDataSource? {
        didSet {
            setUp()
        }
    }
    public weak var delegate: SwippableViewDelegate?
    
    private var nib: UINib?
    
    private var xCenter: CGFloat = 0.0
    private var yCenter: CGFloat = 0.0
    private var originalPoint = CGPoint.zero
    
    private var visibleViews = NSArray()
    private var visibleIndex = 0
    private var modelsCount = 0
    private var visibleReuseCardIndex = 0
    let operationQueue = OperationQueue()
    
    public func registerNib (nib: UINib) {
        self.nib = nib
    }
    
    public func reloadData() {
        guard let dataSource = dataSource else { return }
        if modelsCount >= dataSource.numberOfViews() {
            print("error")
            return
        }
        
        let dataDiff = dataSource.numberOfViews() - modelsCount
        let viewsDiff = dataDiff > 3 - subviews.count ? 3 - subviews.count : dataDiff
        
        if viewsDiff >= 0 {
            modelsCount = dataSource.numberOfViews()
            renderViews(number: viewsDiff, startIndex: visibleIndex + 1)
        }
    }
    
    public func autoSwipe(direction: swipeDirection) {
        operationQueue.maxConcurrentOperationCount = 1
        
        if operationQueue.operations.count > 1 {
            operationQueue.cancelAllOperations()
        }
        
        let animateOperation = AutomaticSwipeOperation(direction: direction, superview: self) { }
        operationQueue.addOperation(animateOperation)
    }
}

extension SwippableView {
    private func setUp() {
        clipsToBounds = false
        guard nib != nil else {
            print("Nib is nil")
            return
        }
        drawViews()
    }
    
    private func drawViews() {
        guard let dataSource = dataSource else { return }
        modelsCount = dataSource.numberOfViews()
        
        if dataSource.numberOfViews() == 0 { return }
        
        let viewsNumber = dataSource.numberOfViews() >= 3 ? 3 : modelsCount
        renderViews(number: viewsNumber, startIndex: visibleIndex)
    }
    
    private func renderViews(number: Int, startIndex: Int) {
        let viewsArray = NSMutableArray()
        var indexCounter = startIndex
        
        guard let dataSource = dataSource, let nib = nib else { return }
        
        for _ in 0..<number {
            let rawView = nib.instantiate(withOwner: nil, options: nil)[0] as! UIView
            dataSource.view(view: rawView, atIndex: indexCounter)
            
            rawView.frame = bounds
            rawView.layer.cornerRadius = 10
            insertSubview(rawView, at: 0)
            viewsArray.add(rawView)
            indexCounter += 1
        }
        visibleViews = viewsArray.count > 0 ?  viewsArray : visibleViews
        addRecognizers()
    }
    
    private func addRecognizers () {
        for i in 0..<visibleViews.count {
            let view = visibleViews[i] as! UIView
            addPanGestureRecognizer(view: view)
        }
    }
    
    private func addPanGestureRecognizer(view: UIView) {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(dragged))
        view.addGestureRecognizer(recognizer)
    }
}

//MARK:- селекторы жестовых распознавателей
extension SwippableView {
    @objc private func dragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let view = gestureRecognizer.view else { return }
        // MARK: нахожу смещение по x и y относительно себя
        xCenter = gestureRecognizer.translation(in: self).x
        yCenter = gestureRecognizer.translation(in: self).y
        switch gestureRecognizer.state {
        case .began:
            originalPoint = view.center
        case .changed:
            // MARK: перемещаем view за gesture и наклоняем в левую или правую сторону
            let rotationStrength = min(xCenter / UIScreen.main.bounds.size.width, 1)
            let rotationAngel = .pi/8 * rotationStrength
            view.center = CGPoint(x: originalPoint.x + xCenter, y: originalPoint.y + yCenter)
            let transforms = CGAffineTransform(rotationAngle: rotationAngel)
            view.transform = transforms
        case .ended:
            actionAfterSwipe(view: view)
        default:
            break
        }
    }
    
    private func viewGetRight(view: UIView) {
        // MARK: увозим после свайпа вверх или вниз в зависимости от yCenter, а также вправо
        let finishPoint = CGPoint(x: frame.size.width * 2, y: 2 * yCenter + originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: { view.center = finishPoint }) { [weak self] _ in
            guard let self = self else { return }
            self.handleAction(view: view, direction: .right)
        }
    }
    
    private func viewGetLeft(view: UIView) {
        // MARK: увозим после свайпа вверх или вниз в зависимости от yCenter, а также влево
        let finishPoint = CGPoint(x: -frame.size.width * 2, y: 2 * yCenter + originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: { view.center = finishPoint }) { [weak self] _ in
            guard let self = self else { return }
            self.handleAction(view: view, direction: .left)
        }
    }
    
    func actionAfterSwipe(view: UIView) {
        // MARK: если попадаем в четверть экрана, то происходит свайп
        if xCenter > (UIScreen.main.bounds.size.width / 4)  {
            viewGetRight(view: view)
        }
        else if xCenter < -(UIScreen.main.bounds.size.width / 4) {
            viewGetLeft(view: view)
        }
        else {
            // MARK: возвращаем на место, если не довели до края
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [], animations: {
                view.center = self.originalPoint
                view.transform = CGAffineTransform(rotationAngle: 0)
            })
        }
    }
    
    func handleAction(view: UIView, direction: swipeDirection) {
        delegate?.willSwiped(index: visibleIndex, direction: direction)
        view.removeFromSuperview()
        if modelsCount - visibleIndex <= 3 {
            if visibleIndex < modelsCount  {
                visibleIndex += 1
                return
            }
        }
        visibleReuseCardIndex = visibleReuseCardIndex == 2 ? 0 : visibleReuseCardIndex + 1
        
        dataSource?.view(view: view, atIndex: visibleIndex + 3 )
        view.transform = CGAffineTransform.identity
        view.frame = bounds
        insertSubview(view, at: 0)
        visibleIndex += 1
    }
}
