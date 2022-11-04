//
//  ProfileViewController.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/03.
//

import UIKit

import Kingfisher
import RxSwift
import RxCocoa

final class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    
    let viewModel = ProfileViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        logOutButton()
    }
}

extension ProfileViewController {
    private func configure() {
        viewModel.requestProfile { [weak self] result in
            switch result {
            case .success(let data):
                let url = URL(string: data.user.photo)
                self?.profileView.imageView.kf.setImage(with: url)
                self?.profileView.nameLabel.text = data.user.username
                self?.profileView.emailLabel.text = data.user.email
            case .failure(let error):
                self?.showAlert(message: "\(error)")
            }
        }
    }
    
    private func logOutButton() {
        profileView.logout.rx.tap
            .bind { [weak self] in
                UserDefaults.standard.removeObject(forKey: "token")
                self?.resetWindow()
            }
            .disposed(by: disposeBag)
    }
}

//MARK: - user defined functions
extension ProfileViewController {
    
    func resetWindow() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = BeginViewController()
        let navi = UINavigationController(rootViewController: vc)
        
        sceneDelegate?.window?.rootViewController = navi
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
