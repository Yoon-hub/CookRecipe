//
//  LoginView.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/02.
//

import UIKit

import SnapKit
import Then

final class LoginView: UIView {
    
    let idlabel = UILabel().then {
        $0.text = "이메일"
    }
    
    let idTextField = UITextField().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 10
        $0.setLeftPaddingPoints(15)
        $0.autocapitalizationType = .none
    }
    let pwTextField = UITextField().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 10
        $0.setLeftPaddingPoints(15)
        $0.autocapitalizationType = .none
    }
    
    let pwlabel = UILabel().then {
        $0.text = "비밀번호"
    }
    
    let loginButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "buttonColor")
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .white
        [idlabel, pwlabel, idTextField, pwTextField, loginButton].forEach { self.addSubview($0) }
    }
    
    private func setConstraints() {
        idlabel.snp.makeConstraints {
            $0.centerY.equalTo(self).offset(-150)
            $0.leading.equalTo(self).offset(20)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(idlabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(44)
        }
        
        pwlabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(15)
            $0.leading.equalTo(self).offset(20)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(pwlabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(44)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(53)
        }
    }
    
}

