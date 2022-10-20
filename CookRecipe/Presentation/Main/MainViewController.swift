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
    
    //vc Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfigure()
        configure()
        setBind()
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
    
    private func setBind() {
        viewModel.recipeList.bind { cookRecipe in
            print(cookRecipe)
        }
    }
}

//MARK: - searchbar
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.requestRecipe(text: searchBar.text!)
    }
}
