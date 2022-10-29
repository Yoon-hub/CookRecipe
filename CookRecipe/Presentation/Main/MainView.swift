//
//  MainView.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/20.
//

import UIKit

import SnapKit

final class MainView: UIView {
    
    let searchBar = UISearchBar()
    
    lazy var collectionView: UICollectionView = {
//        let config = UICollectionLayoutListConfiguration(appearance: .plain)
//        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.compositionalLayout())
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
}

extension MainView {
    
    private func configure() {
        self.backgroundColor = .white
        [searchBar, collectionView].forEach { self.addSubview($0)}
    }
    
    private func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.leading.trailing.top.equalTo(self.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private func compositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}
