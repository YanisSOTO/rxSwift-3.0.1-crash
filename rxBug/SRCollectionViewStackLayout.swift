//
//  SRCollectionViewStackLayout.swift
//  rxBug
//
//  Created by Soto Yanis on 12/01/2017.
//  Copyright © 2017 Soto Yanis. All rights reserved.
//

import Foundation
import UIKit

import Foundation

class SRCollectionViewStackLayout: UICollectionViewFlowLayout {
    var itemWidth:Int = 250;
    
    override init(){
        super.init();
        self.commonInit()
    }
    
    init(itemWidth: Int){
        super.init();
        self.itemWidth = itemWidth;
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.commonInit()
        
    }
    
    func commonInit()
    {
        //self.itemSize = CGSize(width: itemWidth, height: 150);
        
        //set minimum layout requirements
        self.scrollDirection = .vertical;
        self.minimumInteritemSpacing = 0;
        
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return proposedContentOffset //CGPointMake(proposedContentOffset.x, proposedContentOffset.y + 150);
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
    
    
    
    override var collectionViewContentSize: CGSize
    {
        guard let collectionView = self.collectionView else {return CGSize(width: 0,height: 0);}
        
        let offset: CGFloat = self.itemSize.height / 150 * 50;
        
        let ySize = CGFloat(Float(collectionView.numberOfItems(inSection: 0)) + 1.5) * (self.itemSize.height - offset);
        let xSize = CGFloat(collectionView.numberOfSections) * self.itemSize.width;
        
        var contentSize = CGSize(width: xSize, height: ySize);
        
        if (collectionView.bounds.size.width > contentSize.width){
            contentSize.width = collectionView.bounds.size.width;
        }
        
        if (collectionView.bounds.size.height > contentSize.height){
            contentSize.height = collectionView.bounds.size.height;
        }
        
        return contentSize;
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        
        let offset: CGFloat = self.itemSize.height / 150 * 50;
        
        let newRect = CGRect(x: rect.origin.x, y: rect.origin.y + CGFloat(Int(rect.origin.y / 150)) * offset, width: rect.width, height: rect.height + CGFloat(Int(rect.height / 150)) * offset)
        
        let attributesArray = super.layoutAttributesForElements(in: newRect);
        guard let collectionView = self.collectionView else {return attributesArray;}
        let numberOfItems = collectionView.numberOfItems(inSection: 0);
        
        for attributes in attributesArray ?? [] {
            let xPosition = attributes.center.x;
            var yPosition = attributes.center.y;
            
            if (attributes.indexPath.row == 0) {
                attributes.zIndex = 999999; // Put the first cell on top of the stack
            } else {
                yPosition -= CGFloat(offset * CGFloat(attributes.indexPath.row));
                attributes.zIndex = numberOfItems - attributes.indexPath.row; //Other cells below the first one
            }
            
            attributes.center = CGPoint(x: xPosition, y: yPosition);
        }
        
        //print(attributesArray);
        
        return attributesArray;
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath);
        return attributes;
    }
}
