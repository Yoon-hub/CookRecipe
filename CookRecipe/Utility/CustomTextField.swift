//
//  CustomTextField.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/06.
//

import UIKit

open class CustomTextField: UITextField {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        setLeftPaddingPoints(15)
        autocapitalizationType = .none

    }
}
