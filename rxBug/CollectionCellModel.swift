//
//  CollectionCellModel.swift
//  rxBug
//
//  Created by Soto Yanis on 07/01/2017.
//  Copyright © 2017 Soto Yanis. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources


func ==(lhs: CollectionCellModel, rhs: CollectionCellModel) -> Bool {
    return lhs.hashValue == rhs.hashValue;
}

final class CollectionCellModel: Hashable, Equatable, IdentifiableType {
    
    var disposeBag = DisposeBag()
    
    var text = Variable<String?>("")
    
    
    var hashValue: Int {
        get { return "1".hashValue  }
    }
    
    var identity: Int {
        get { return hashValue }
    }
    
    init(test: String) {
        text.value = test
    }
    
    
}
