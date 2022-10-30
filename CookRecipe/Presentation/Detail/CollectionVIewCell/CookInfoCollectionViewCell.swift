//
//  CookInfoCollectionViewCell.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/30.
//

import UIKit

import SnapKit

final class CookInfoCollectionViewCell: UITableViewCell {
    
    let titleLable: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 19)
        return view
    }()
    
    let bookMarkButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 50)
        button.setImage(UIImage(systemName: "bookmark", withConfiguration: config), for: .normal)
        button.tintColor = UIColor(named: "appColor")
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titleLable)
        contentView.addSubview(bookMarkButton)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        titleLable.snp.makeConstraints {
            $0.leading.equalTo(self).offset(20)
            $0.centerY.equalTo(self)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-20)
            $0.centerY.equalTo(self)
            $0.width.height.equalTo(28)
        }
    }
    
    
}
