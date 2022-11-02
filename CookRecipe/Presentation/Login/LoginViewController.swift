//
//  LoginViewController.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/02.
//

import UIKit

import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    let viewModel = LoginViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateConfigure()
        naviagtionConfigure()
        gestureConfigure()
        bindTextField()
        checkValidation()
    }

}

//MARK: - Bind
extension LoginViewController {
    
    private func bindTextField() {
        loginView.idTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        loginView.pwTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
    }
    
    private func checkValidation() {
        
        Observable.combineLatest(loginView.idTextField.rx.text.orEmpty, loginView.pwTextField.rx.text.orEmpty)
            .map { id, pw in
                return !(id.contains("@") && pw.count >= 8)
            }
            .bind(to: loginView.loginButton.rx.isHidden)
            .disposed(by: disposeBag)
        
    }
    
}

//MARK: - Configure
extension LoginViewController {
    
    private func naviagtionConfigure() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.title = "로그인"
    }
    
    private func delegateConfigure() {
        loginView.idTextField.delegate = self
        loginView.pwTextField.delegate = self
    }
    
    private func gestureConfigure() {
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(tapGestureClicked))
              view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func tapGestureClicked() {
            view.endEditing(true)
        }
    
}

//MARK: - TextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "buttonColor")?.cgColor
        textField.backgroundColor = .white
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        textField.backgroundColor = .systemGray6
    }
    
}
