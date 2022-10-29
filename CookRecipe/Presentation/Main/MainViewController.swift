//
//  MainViewController.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/20.
//

import UIKit

import Kingfisher
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
        subscirbe()
        subscribeSearchBar()
    }
}

//MARK: - configure
extension MainViewController {
    
    private func navigationConfigure() {
        self.navigationItem.title = "레시피 검색"
    }
    
    private func subscirbe() {
        viewModel.recipeList
            .subscribe(onNext: { [weak self] cookRecipe in
                var snapshot = NSDiffableDataSourceSnapshot<Int, [String:String]>()
                snapshot.appendSections([0])
                snapshot.appendItems(cookRecipe.cookrcp01.row)
                self?.dataSource.apply(snapshot)
            })
            .disposed(by: dispoasBag) // 한번 실패하면 error가 발생하고 disposed 되버려서 다시 실행이 안된다
    }
}

//MARK: - searchBar RxCocoa

extension MainViewController {
    func subscribeSearchBar() {
        mainView.searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)  // 키보드 입력이 종료되고 1초후에
            .distinctUntilChanged() // 한번 검색한건 안함
            .withUnretained(self)
            .bind { vc, value in
                print(value)
                guard value != "" else { return }
                vc.viewModel.requestRecipe(text: value) { [weak self] in
                    let alert = UIAlertController(title: "", message: "검색하신 레시피가 없습니다.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .cancel)
                    alert.addAction(ok)
                    self?.present(alert, animated: true)
                }
            }
            .disposed(by: dispoasBag)
    }
}


//MARK: - collectionView
extension MainViewController {
    private func cellRegiste() {
        let cellRegisteration = UICollectionView.CellRegistration<MainCollectionViewCell, [String:String]> { cell, indexPath, itemIdentifier in
            
            cell.titleLabel.text = itemIdentifier["RCP_NM"]
            let url = URL(string: itemIdentifier["ATT_FILE_NO_MAIN"]!)
            cell.imageView.kf.setImage(with: url)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
    
    
}
