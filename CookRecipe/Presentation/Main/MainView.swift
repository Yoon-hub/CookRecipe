//
//  MainView.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/20.
//

import UIKit

import SnapKit
import Then

final class MainView: UIView {
    
    let searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    
    private func configure() {
        self.backgroundColor = .white
        self.addSubview(searchBar)
    }
    
    private func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.leading.trailing.top.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
