//
//  LoginViewController.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/02.
//

import UIKit

import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    private let viewModel = LoginViewModel()
    
    private let disposeBag = DisposeBag()
    
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
        loginButton()
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
    
    private func loginButton() {
        loginView.loginButton.rx.tap
            .bind { [weak self]  in
                self?.viewModel.requestLogin(email: (self?.loginView.idTextField.text)!, password: (self?.loginView.pwTextField.text)!) { result in
                    switch result {
                    case .success(_):
                        let vc = MainViewController()
                        self?.transition(vc, transitionStyle: .naviagionModal)
                    case .failure(let status):
                        let alert = self?.showAlert(message: "\(status) 에러!!!!")
                        self?.present(alert!, animated: true)
                    }
                }
            }
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


//MARK: - user defined functions
extension LoginViewController {
    
    func resetWindow() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = MainViewController()
        let navi = UINavigationController(rootViewController: vc)
        
        sceneDelegate?.window?.rootViewController = navi
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
