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
    
    let disposeBag = DisposeBag()
    override func loadView() {
        self.view = beginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton()
        registButton()
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
            .disposed(by: disposeBag)
    }
    
    private func registButton() {
        beginView.registButton.rx.tap
            .bind { [weak self] in
                let vc = RegistViewController()
                self?.transition(vc, transitionStyle: .navigation)
            }
            .disposed(by: disposeBag)
    }
}
