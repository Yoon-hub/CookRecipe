//
//  BeginView.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/02.
//

import UIKit

import SnapKit

final class BeginView: UIView {
    
    let mainLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.text = "요리\n   조리법"
        view.font = .boldSystemFont(ofSize: 30)
        view.textColor = UIColor(named: "mainColor")
        return view
    }()
    
    let loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("로그인", for: .normal)
        view.tintColor = .black
        view.backgroundColor = UIColor(named: "buttonColor")
        view.layer.cornerRadius = 8
        return view
    }()
    
    let registButton: UIButton = {
        let view = UIButton()
        view.setTitle("회원가입", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        return view
    }()
    
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
        [mainLabel, loginButton, registButton].forEach { self.addSubview($0) }
    }
    
    private func setConstraints() {
        mainLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.centerY.equalTo(self).offset(-60)
        }
        
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-40)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(37)
        }
        
        registButton.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.bottom)
            $0.leading.equalTo(loginButton.snp.trailing).offset(15)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            $0.width.equalTo(loginButton.snp.width)
            $0.height.equalTo(37)
        }
    }
    
}
