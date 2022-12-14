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

final class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    private let viewModel = DetailViewModel()
    
    private let disposeBag = DisposeBag()
        
    var dic: [String:String]?
    
    private var input: DetailViewModel.Input!
    private var output: DetailViewModel.Output!
    
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionCookInfo>!
    
    //Life Cycle
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputOutput()
        delegateConfigure()
        configureHeader()
        navigationConfigure()
        setDataSource()
        tableViewHeader()
        tableViewBind()
        viewModel.fetchInfo(data: dic!)
  
        
    }
}

//MARK: - Configure
extension DetailViewController {
    
    private func delegateConfigure() {
        let scrollView = detailView.tableView as UIScrollView
        scrollView.delegate = self
        detailView.tableView.delegate = self
    }
    
    private func navigationConfigure() {
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
    }
    
    private func inputOutput() {
        input = DetailViewModel.Input()
        output = viewModel.transform(input: input)
    }
}

//MARK: - TableView
extension DetailViewController {
    
    private func setDataSource() {
        dataSource = RxTableViewSectionedReloadDataSource<SectionCookInfo>(configureCell: { dataSource, tableView, indexPath, item in
            switch item {
            case let .top(cookInfo):
                let cell = tableView.dequeueReusableCell(withIdentifier: CookInfoCollectionViewCell.reusable, for: indexPath) as! CookInfoCollectionViewCell
                cell.titleLable.text = cookInfo.name
                let button = cell.setButtonImage(favorite: cookInfo.favorite)
                cell.bookMarkButton.setImage(button, for: .normal)
                return cell
            case let .middle(cookIngredient):
                let cell = tableView.dequeueReusableCell(withIdentifier: CookIngredientTableViewCell.reusable, for: indexPath) as! CookIngredientTableViewCell
                cell.ingredentLabel.text = cookIngredient.ingredient
                return cell
            case let .bottom(recipeSection):
                let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.reusable, for: indexPath) as! RecipeTableViewCell
                cell.contentLabel.text = recipeSection.content
                return cell
            }
        })
    }
    
    private func tableViewBind() {
        output.cookInfo
            .bind(to: detailView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    private func tableViewHeader() {
        dataSource.titleForHeaderInSection = { dataSource, index in
          return dataSource.sectionModels[index].header
        }
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

//MARK: - TableViewDelegate
extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section: [Int:CGFloat] = [0:40, 1:110, 2:75]
            return section[indexPath.section]!
        }

}
