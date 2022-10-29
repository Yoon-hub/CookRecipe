//
//  DetailViewController.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/29.
//

import UIKit

import Kingfisher

class DetailViewController: UIViewController {

    let detailView = DetailView()
    
    var dic: [String:String]?
    
    //Life Cycle
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureHeader()
        navigationConfigure()
        
    }
}

//MARK: - Configure
extension DetailViewController {
    
    private func configure() {
        let scrollView = detailView.tableView as UIScrollView
        scrollView.delegate = self
    }
    
    private func navigationConfigure() {
        navigationController?.navigationBar.topItem?.title = ""
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()

        navigationController?.navigationBar.tintColor = .black

        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        
    }
}


//MARK: - Set TableView Header
extension DetailViewController: UIScrollViewDelegate {
    
    private func configureHeader() {
        let headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        let url = URL(string: dic![RowDictionary.image.rawValue]!)
        headerView.imageView.kf.setImage(with: url)
         detailView.tableView.tableHeaderView = headerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let headerView = detailView.tableView.tableHeaderView as! StretchyTableHeaderView
         headerView.scrollViewDidScroll(scrollView: scrollView)
     }
     
}
