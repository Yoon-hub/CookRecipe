//
//  RecipeTableViewCell.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/31.
//

import UIKit

import SnapKit

final class RecipeTableViewCell: UITableViewCell {
    
    let numberLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.backgroundColor = UIColor(named: "appColor")
        return view
    }()
    
    let contentLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [contentLabel].forEach { self.addSubview($0) }
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
//        numberLabel.snp.makeConstraints {
//            $0.leading.equalTo(self).offset(20)
//            $0.centerY.equalTo(self)
//        }
//
        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.centerY.equalTo(self)
        }
    }
    
    
}
 
