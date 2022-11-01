//
//  Alert.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/01.
//

import UIKit

extension UIViewController {
    
    func showAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        return alert
    }
    
}
