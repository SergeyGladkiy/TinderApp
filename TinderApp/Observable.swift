//
//  Observable.swift
//  TinderApp
//
//  Created by Serg on 11.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class Observable<T> {
    var observable: T {
        didSet {
            onChanged?(observable)
        }
    }
    
    private var onChanged: ((T)->())?
    
    func bind(bindingClouser: @escaping (T)->()) {
        bindingClouser(observable)
        onChanged = bindingClouser
    }
    
    init(observable: T) {
        self.observable = observable
    }
}
