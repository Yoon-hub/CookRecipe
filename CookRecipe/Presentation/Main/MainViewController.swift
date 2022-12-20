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
    
    private let mainView = MainView()
    
    private let viewModel = MainViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, [String:String]>!
    
    private var dispoasBag = DisposeBag()
    
    private var input: MainViewModel.Input!
    var output: MainViewModel.Output!
    
    //vc Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfigure()
        inputOutput()
        cellRegiste()
        subscirbe()
        subscribeSearchBar()
        cellSelected()
    
    }
}

//MARK: - configure
extension MainViewController {
    
    private func inputOutput() {
        input = MainViewModel.Input(searchBar: mainView.searchBar.rx.text, itemSelected: mainView.collectionView.rx.itemSelected)
        output = viewModel.transform(input: input)
    }
    
    private func navigationConfigure() {
        self.navigationItem.title = "레시피 검색"
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: self, action: #selector(profileButton))
        self.navigationItem.rightBarButtonItem = profileButton
        self.navigationController?.navigationBar.tintColor = .black
    }
    			
    private func subscirbe() {
        output.recipeList
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
    private func subscribeSearchBar() {
        output.searchBar
            .withUnretained(self)
            .bind { vc, value in
                guard value != "" else { return }
                vc.viewModel.requestRecipe(text: value) { [weak self] message in
                    let alert = self?.showAlert(message: message)
                    self?.present(alert!, animated: true)
                }
            }
            .disposed(by: dispoasBag)
    }
}


//MARK: - collectionView
extension MainViewController {
    private func cellRegiste() {
        let cellRegisteration = UICollectionView.CellRegistration<MainCollectionViewCell, [String:String]> { cell, indexPath, itemIdentifier in
            
            cell.titleLabel.text = itemIdentifier[RowDictionary.title.rawValue]
            let url = URL(string: itemIdentifier[RowDictionary.image.rawValue]!)
            cell.imageView.kf.setImage(with: url)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
    
    private func cellSelected() {
        output.itemSelected
            .bind { [weak self] in
                guard let item = self?.dataSource.itemIdentifier(for: $0) else { return }
                let vc = DetailViewController()
                vc.dic = item
                self?.transition(vc, transitionStyle: .navigation)
                //dump(item)
            }
            .disposed(by: dispoasBag)
    }
}

//MARK: - UserDefined
extension MainViewController {
    
    @objc
    private func profileButton() {
        guard let a =  UserDefaults.standard.string(forKey: "token") else {
            print("사용이 불가능합니다.")
            let alert = showAlert(message: "비회원 사용자는 사용이 불가능합니다.")
            present(alert, animated: true)
            return
        }
        let vc = ProfileViewController()
        transition(vc, transitionStyle: .navigation)
    }
}
