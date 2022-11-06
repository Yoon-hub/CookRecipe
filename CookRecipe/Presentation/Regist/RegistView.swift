//
//  RegistView.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/06.
//

import UIKit

import SnapKit
import Then

final class RegistView: UIView {
    
    let nameLabel = UILabel().then {
        $0.text = "이름"
    }
    
    let idlabel = UILabel().then {
        $0.text = "이메일"
    }
    
    let idCheckLabel = UILabel().then {
        $0.text = "이메일에는 반드시 @가 포함되어야 합니다."
        $0.textColor = .blue
        $0.font = .systemFont(ofSize: 11)
    }
    
    let pwCheckLabel = UILabel().then {
        $0.text = "비밀번호는 반드시 8자리 이상이어야 합니다."
        $0.textColor = .blue
        $0.font = .systemFont(ofSize: 11)
    }
    
    let nameTextField = CustomTextField()
    let idTextField = CustomTextField()
    let pwTextField = CustomTextField()
    
    let pwlabel = UILabel().then {
        $0.text = "비밀번호"
    }
    
    let registButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "buttonColor")
        $0.setTitle("회원가입", for: .normal)
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
        [nameLabel, idlabel, pwlabel, nameTextField, idTextField, pwTextField, registButton, idCheckLabel, pwCheckLabel].forEach { self.addSubview($0) }
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
        
        nameTextField.snp.makeConstraints {
            $0.bottom.equalTo(idlabel.snp.top).offset(-15)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(44)
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.equalTo(nameTextField.snp.top).offset(-5)
            $0.horizontalEdges.equalTo(self).inset(20)
        }
        
        registButton.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(53)
        }
        
        idCheckLabel.snp.makeConstraints {
            $0.centerY.equalTo(idlabel)
            $0.leading.equalTo(idlabel.snp.trailing).offset(5)
        }
        
        pwCheckLabel.snp.makeConstraints {
            $0.centerY.equalTo(pwlabel)
            $0.leading.equalTo(pwlabel.snp.trailing).offset(5)
        }
    }
    
}

