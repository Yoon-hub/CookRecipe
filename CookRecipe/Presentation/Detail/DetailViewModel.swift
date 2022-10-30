//
//  DetailViewModel.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/30.
//

import Foundation

import RxSwift

class DetailViewModel {
    
    let cookInfo = PublishSubject<[SectionCookInfo]>()
    
    func fetchInfo(data: [String:String]) {
        let section = [
            SectionCookInfo(items: [CookInfo(name: data[RowDictionary.title.rawValue]!,favorite: true )])
        ]
        cookInfo.onNext(section)
    }
    
}
