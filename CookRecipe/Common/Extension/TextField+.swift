//
//  TextField+.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/02.
//

import UIKit

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat) { //왼쪽에 여백 주기
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
