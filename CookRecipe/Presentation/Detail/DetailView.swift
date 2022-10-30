//
//  DetailView.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/29.
//

import UIKit

import SnapKit

final class DetailView: UIView {
    
    let tableView: UITableView = {
       let view = UITableView()
        view.register(CookInfoCollectionViewCell.self, forCellReuseIdentifier: CookInfoCollectionViewCell.reusable)
        view.register(CookIngredientTableViewCell.self, forCellReuseIdentifier: CookIngredientTableViewCell.reusable)
        view.separatorStyle = .none
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
        self.addSubview(tableView)
    }
    
    private func setConstraints() {
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
