//
//  ProfileView.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/04.
//

import UIKit

import SnapKit
import Then

final class ProfileView: UIView {
    
    let imageView = UIImageView().then {
        //$0.layer.cornerRadius = $0.frame.height
        $0.backgroundColor = .brown
    }
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let logout = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.backgroundColor = UIColor(named: "buttonColor")
        $0.layer.cornerRadius = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        [imageView, nameLabel, emailLabel, logout].forEach{ self.addSubview($0) }
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        imageView.snp.makeConstraints {
            $0.centerY.equalTo(self).offset(-40)
            $0.centerX.equalTo(self)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.centerX.equalTo(self)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.centerX.equalTo(self)
        }
        
        logout.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(self).inset(20)
            $0.height.equalTo(44)
        }
        
    }
    
    
    
}
