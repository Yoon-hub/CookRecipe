//
//  ReuesableProtocol.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/31.
//

import UIKit

protocol ReusableProtocol {
    static var reusable: String { get }
}

extension UITableViewCell: ReusableProtocol {
    static var reusable: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableProtocol {
    static var reusable: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: ReusableProtocol {
    static var reusable: String {
        return String(describing: self)
    }
}
