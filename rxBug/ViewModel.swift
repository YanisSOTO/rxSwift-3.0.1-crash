//
//  ViewModel.swift
//  rxBug
//
//  Created by Soto Yanis on 07/01/2017.
//  Copyright © 2017 Soto Yanis. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

final class ViewModel {
    let disposeBag = DisposeBag()
    
    var cellsViewModel = Variable<[AnimatableSectionModel<String, CollectionCellModel>]>([])
    let fetcher = Fetcher()

    init () {
        binding()
    }
    
    func binding () {
        fetcher.fetch()        
        fetcher
            .resultFetch
            .asObservable()
            .map {[AnimatableSectionModel(model: "all", items: $0.map(CollectionCellModel.init))]}
            .bindTo(cellsViewModel)
            .addDisposableTo(disposeBag)
 
    }
    
}
