//
//  MainCollectionViewCell.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/28.
//

import UIKit

import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    
 
    let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 14
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configue()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configue() {
        [imageView, titleLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(88)
            $0.centerY.equalTo(self)
            $0.leading.equalTo(self).offset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.trailing.equalTo(self).offset(-20)
        }
        
        
    }

}
