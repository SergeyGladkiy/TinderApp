//
//  MainScreenViewController.swift
//  TinderApp
//
//  Created by Serg on 11.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import UIKit
import UtilsSwippableView

class MainScreenViewController: UIViewController {
    
    @IBOutlet private weak var swippableView: SwippableView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var dislikeImageView: UIImageView!
    
    private var imageCount = 0
    private var currentIndex = 0
    
    private let viewModel: InterfaceMainScreenViewModel
    private let identifier = "MainScreenViewController"
    
    init(viewModel: InterfaceMainScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: identifier, bundle: Bundle(identifier: identifier))
        
        
        
        self.viewModel.state.bind { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .initial:
                return
            case .finishedLoad:
                self.swippableView.reloadData()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizers()
        
        swippableView.layer.cornerRadius = 10
        //swippableView.clipsToBounds = true
        
        let viewNib = UINib(nibName: "SwippableView", bundle: nil)
        swippableView.registerNib(nib: viewNib)
        swippableView.dataSource = self
        swippableView.delegate = self
        
        viewModel.getTinderData()
    }
    
    private func setupGestureRecognizers() {
        let tapGestureRecognazerLikeImage = UITapGestureRecognizer(target: self, action: #selector(likeAction))
        self.likeImageView.addGestureRecognizer(tapGestureRecognazerLikeImage)
        
        let tapGestureRecongnazerDislikeImage = UITapGestureRecognizer(target: self, action: #selector(dislikeAction))
    self.dislikeImageView.addGestureRecognizer(tapGestureRecongnazerDislikeImage)
    }
    
    @objc func likeAction() {
        if viewModel.dataSource.observable.count > 0 {
            swippableView.autoSwipe(direction: .right)
        }
    }
    
    @objc func dislikeAction() {
        if viewModel.dataSource.observable.count > 0 {
            swippableView.autoSwipe(direction: .left)
        }
        
    }

}

extension MainScreenViewController: SwippableViewDelegate, SwippableViewDataSource {
    func willSwiped(index: Int, direction: swipeDirection) {
        
    }
    
    func view(view: UIView, atIndex index: Int) {
        
    }
    
    func numberOfViews() -> Int {
        return viewModel.dataSource.observable.count
    }
    
    
}
