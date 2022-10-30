//
//  DetailViewController.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/29.
//

import UIKit

import Kingfisher
import RxSwift
import RxCocoa
import RxDataSources

class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    private let viewModel = DetailViewModel()
    
    private let disposeBag = DisposeBag()
    
    var dic: [String:String]?
    
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionCookInfo>!
    
    //Life Cycle
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateConfigure()
        configureHeader()
        navigationConfigure()
        setDataSource()
        tableViewBind()
        viewModel.fetchInfo(data: dic!)
    }
}

//MARK: - Configure
extension DetailViewController {
    
    private func delegateConfigure() {
        let scrollView = detailView.tableView as UIScrollView
        scrollView.delegate = self
    }
    
    private func navigationConfigure() {
       // navigationController?.navigationBar.topItem?.title = ""
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()

        navigationController?.navigationBar.tintColor = .black

        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        
    }
}

//MARK: - TableView
extension DetailViewController {
    
    func setDataSource() {
        dataSource = RxTableViewSectionedReloadDataSource<SectionCookInfo>(configureCell: { dataSource, tableView, indexPath, item in
   
            let cell = tableView.dequeueReusableCell(withIdentifier: "CookInfoCollectionViewCell", for: indexPath) as! CookInfoCollectionViewCell
            cell.titleLable.text = item.name
            let config = UIImage.SymbolConfiguration(pointSize: 100)
            let button = item.favorite ? UIImage(systemName: "bookmark", withConfiguration: config) : UIImage(systemName: "bookmark.fill", withConfiguration: config)
            cell.bookMarkButton.setImage(button, for: .normal)
            return cell
            
        })
    }
    
    func tableViewBind() {
        viewModel.cookInfo
            .bind(to: detailView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
    


//MARK: - Set TableView HeaderView
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
