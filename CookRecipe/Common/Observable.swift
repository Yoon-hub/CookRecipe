//
//  Observable.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/21.
//

import Foundation

class Observalble<T> {
    
    typealias completion = (T) -> Void
    
    private var listerner: (completion)?
    
    var value: T {
        didSet {
            listerner?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping completion) {
        closure(value)
        listerner = closure
    }
}

