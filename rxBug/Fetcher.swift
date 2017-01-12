//
//  Fetcher.swift
//  rxBug
//
//  Created by Soto Yanis on 07/01/2017.
//  Copyright © 2017 Soto Yanis. All rights reserved.
//

import Foundation
import RxSwift

class Fetcher {
    
    let disposeBag = DisposeBag();
    var resultFetch = Variable<[String]>([])
    
    init() {
        fetch()
    }
    
    func fetch(){
        resultFetch.value = ["TEXT_1", "TEXT_2", "TEXT_3", "TEXT_4",]
    }
}
