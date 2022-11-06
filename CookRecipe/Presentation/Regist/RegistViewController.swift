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
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = registView
        
        naviagtionConfigure()
        delegateConfigure()
        gestureConfigure()
        checkValidation()
        bindTextField()
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
