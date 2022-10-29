//
//  Transition+.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/29.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case navigation
    }
    
    func transition<T: UIViewController>(_ vc: T, transitionStyle: TransitionStyle) {
        switch transitionStyle {
        case .navigation:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
