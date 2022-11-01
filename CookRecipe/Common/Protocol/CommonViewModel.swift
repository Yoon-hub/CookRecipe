//
//  CommonViewModel.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/01.
//

import Foundation

protocol CommonViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
