//
//  RegistViewController.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/06.
//  loginView랑 하나로 묶기

import UIKit

import RxSwift
import RxCocoa

final class RegistViewController: UIViewController {
    
    let registView = RegistView()
    
    let viewModel = RegistViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = registView
        
        naviagtionConfigure()
        delegateConfigure()
        gestureConfigure()
        checkValidation()
        bindTextField()
        registButton()
    }
}

//MARK: - Configure
extension RegistViewController {
    
    private func naviagtionConfigure() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.title = "회원가입"
    }
    
    private func delegateConfigure() {
        registView.idTextField.delegate = self
        registView.pwTextField.delegate = self
        registView.nameTextField.delegate = self
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

//MARK: - Bind
extension RegistViewController {
    
    private func bindTextField() {
        registView.idTextField.rx.text.orEmpty
            .map { $0.contains("@") }
            .bind(to: registView.idCheckLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        registView.pwTextField.rx.text.orEmpty
            .map {$0.count >= 8}
            .bind(to: registView.pwCheckLabel.rx.isHidden)
            .disposed(by: disposeBag)

    }
    
    private func checkValidation() {
        
        Observable.combineLatest(registView.idTextField.rx.text.orEmpty, registView.pwTextField.rx.text.orEmpty, registView.nameTextField.rx.text.orEmpty)
            .map { id, pw, name in
                return !(id.contains("@") && pw.count >= 8 && name.count >= 1)
            }
            .bind(to: registView.registButton.rx.isHidden)
            .disposed(by: disposeBag)
        
    }
    
    private func registButton() {
        registView.registButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.requestRegist(userName: (self?.registView.nameTextField.text)!, email: (self?.registView.idTextField.text)!, password: (self?.registView.pwTextField.text)!, completion: { response, statusCode in
                    if statusCode == 200 {
                        self?.viewModel.requestLogin(email: (self?.registView.idTextField.text)!, password: (self?.registView.pwTextField.text)!) { result in
                            switch result {
                            case .success(_):
                                let vc = MainViewController()
                                self?.transition(vc, transitionStyle: .naviagionModal)
                            case .failure(let status):
                                let alert = self?.showAlert(message: "\(status) 에러!!!!")
                                self?.present(alert!, animated: true)
                            }
                        }
                    } else {
                        let alret = self?.showAlert(message: "\(statusCode)에러")
                        self?.present(alret!, animated: true)
                    }
                })
            }
            .disposed(by: disposeBag)
    }
}

//MARK: - TextFieldDelegate
extension RegistViewController: UITextFieldDelegate {
    
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
