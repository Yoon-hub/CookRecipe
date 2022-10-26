//
//  MainViewController.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/20.
//

import UIKit

import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    
    let mainView = MainView()
    
    let viewModel = MainViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, [String:String]>!
    
    var dispoasBag = DisposeBag()
    
    //vc Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfigure()
        cellRegiste()
        registBind()
        subscribeSearchBar()
    }
}

//MARK: - configure
extension MainViewController {
    
    private func navigationConfigure() {
        self.navigationItem.title = "레시피 검색"
    }
    
    private func registBind() {
        viewModel.recipeList
            .subscribe(onNext: { cookRecipe in
                var snapshot = NSDiffableDataSourceSnapshot<Int, [String:String]>()
                snapshot.appendSections([0])
                snapshot.appendItems(cookRecipe.cookrcp01.row)
                self.dataSource.apply(snapshot)
            }, onError: { error in
                let alert = UIAlertController(title: "", message: "검색하신 레시피가 없습니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .cancel)
                alert.addAction(ok)
                self.present(alert, animated: true)
            })
            .disposed(by: dispoasBag) // 한번 실패하면 error가 발생하고 disposed 되버려서 다시 실행이 안된다
    }
}

//MARK: - searchBar RxCocoa

extension MainViewController {
    func subscribeSearchBar() {
        mainView.searchBar.rx.text.orEmpty
            .debounce(.seconds(2), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .withUnretained(self)
            .bind { vc, value in
                print(value)
                vc.viewModel.requestRecipe(text: value)
            }
            .disposed(by: dispoasBag)
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
