//
//  MainViewController.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/20.
//

import UIKit

final class MainViewController: UIViewController {
    
    let mainView = MainView()
    
    let viewModel = MainViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, [String:String]>!
    
    //vc Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfigure()
        configure()
        cellRegiste()
        registBind()
    }
}

//MARK: - configure
extension MainViewController {
    
    private func navigationConfigure() {
        self.navigationItem.title = "레시피 검색"
    }
    
    private func configure() {
        mainView.searchBar.delegate = self
    }
    
    private func registBind() {
        viewModel.recipeList.bind { cookRecipe in
            var snapshot = NSDiffableDataSourceSnapshot<Int, [String:String]>()
            snapshot.appendSections([0])
            snapshot.appendItems(cookRecipe.cookrcp01.row)
            self.dataSource.apply(snapshot)
        }
    }
}

//MARK: - searchbar
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.requestRecipe(text: searchBar.text!) { [unowned self] in
            let alert = UIAlertController(title: "", message: "검색하신 레시피가 없습니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }   
}

//MARK: - collectionView
extension MainViewController {
    private func cellRegiste() {
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewCell, [String:String]> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier["RCP_NM"]
            
            if let imageURL = itemIdentifier["ATT_FILE_NO_MAIN"] {
                DispatchQueue.global().async {
                    let url = URL(string: imageURL)!
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        content.image = UIImage(data: data!)
                        cell.contentConfiguration = content
                    }
                }
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
    
 
}
