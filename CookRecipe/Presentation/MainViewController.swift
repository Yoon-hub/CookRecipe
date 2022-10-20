//
//  MainViewController.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/20.
//

import UIKit

final class MainViewController: UIViewController {
    
    let mainView = MainView()
    
    //vc Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfigure()
    }
    
}

//configure
extension MainViewController {
    private func navigationConfigure() {
        self.navigationItem.title = "레시피 검색"
    }
}
