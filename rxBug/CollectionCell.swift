//
//  CollectionCell.swift
//  rxBug
//
//  Created by Soto Yanis on 07/01/2017.
//  Copyright © 2017 Soto Yanis. All rights reserved.
//

import Foundation
import RxSwift


class CollectionCell: UICollectionViewCell{
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var textLabel: UILabel!
}
