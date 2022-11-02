//
//  BeginViewController.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/02.
//

import UIKit

import RxSwift
import RxCocoa

final class BeginViewController: UIViewController {
    
    let beginView = BeginView()
    
    override func loadView() {
        self.view = beginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton()
    }
}

//MARK: - Bind
extension BeginViewController {
    
    private func loginButton() {
        beginView.loginButton.rx.tap
            .bind { [weak self] in
                let vc = LoginViewController()
                self?.transition(vc, transitionStyle: .navigation)
            }
    }
}
