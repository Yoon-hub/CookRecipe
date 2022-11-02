//
//  LoginViewModel.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/03.
//

import Foundation

import RxSwift
import RxCocoa

final class LoginViewModel {

    let email = PublishSubject<String>()
    let password = PublishSubject<String>()
    
}
