//
//  CookIngredientTableViewCell.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/31.
//

import UIKit

import SnapKit

final class CookIngredientTableViewCell: UITableViewCell {
    
    let ingredentLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubview(ingredentLabel)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        ingredentLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(self).inset(20)
        }
    }
    
    
}
