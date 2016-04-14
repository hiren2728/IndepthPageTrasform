//
//  UltravisualLayout.swift
//  InHeadLine
//
//  Created by Amrit on 3/31/16.
//  Copyright © 2016 Esig. All rights reserved.
//

import UIKit
class UltravisualLayout: UICollectionViewLayout {
    
    private var contentWidth:CGFloat!
    private var contentHeight:CGFloat!
    private var yOffset:CGFloat = 0
    
    var maxAlpha:CGFloat = 1
    var minAlpha:CGFloat = 0
    
    var widthOffset:CGFloat = 35
    var heightOffset:CGFloat = 35
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var itemWidth:CGFloat{
        return (collectionView?.bounds.width)!
    }
    private var itemHeight:CGFloat{
        return (collectionView?.bounds.height)!
    }
    private var collectionViewHeight:CGFloat{
        return (collectionView?.bounds.height)!
    }

    
    private var numberOfItems:Int{
        return (collectionView?.numberOfItemsInSection(0))!
    }
    
    
    private var dragOffset:CGFloat{
        return (collectionView?.bounds.height)!
    }
    private var currentItemIndex:Int{
        return max(0, Int(collectionView!.contentOffset.y / collectionViewHeight))
    }
    
    var nextItemBecomeCurrentPercentage:CGFloat{
        return (collectionView!.contentOffset.y / (collectionViewHeight)) - CGFloat(currentItemIndex)
    }
    
    override func prepareLayout() {
        cache.removeAll(keepCapacity: false)
        yOffset = 0
        
        for item in 0 ..< numberOfItems{
            
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            attribute.zIndex = -indexPath.row
            
            if (indexPath.item == currentItemIndex+1) && (indexPath.item < numberOfItems){
                
                attribute.alpha = minAlpha + max((maxAlpha-minAlpha) * nextItemBecomeCurrentPercentage, 0)
                let width = itemWidth - widthOffset + (widthOffset * nextItemBecomeCurrentPercentage)
                let height = itemHeight - heightOffset + (heightOffset * nextItemBecomeCurrentPercentage)
                
                let deltaWidth =  width/itemWidth
                let deltaHeight = height/itemHeight
                
                attribute.frame = CGRectMake(0, yOffset, itemWidth, itemHeight)
                attribute.transform = CGAffineTransformMakeScale(deltaWidth, deltaHeight)
                
                attribute.center.y = (collectionView?.center.y)! +  (collectionView?.contentOffset.y)!
                attribute.center.x = (collectionView?.center.x)! + (collectionView?.contentOffset.x)!
                yOffset += collectionViewHeight
                
            }else{
                attribute.frame = CGRectMake(0, yOffset, itemWidth, itemHeight)
                attribute.center.y = (collectionView?.center.y)! + yOffset
                attribute.center.x = (collectionView?.center.x)!
                yOffset += collectionViewHeight
            }
            cache.append(attribute)
        }
    }
    
    //Return the size of ContentView
    override func collectionViewContentSize() -> CGSize {
        contentWidth = (collectionView?.bounds.width)!
        contentHeight = CGFloat(numberOfItems) * (collectionView?.bounds.height)!
        return CGSizeMake(contentWidth, contentHeight)
    }
    
    //Return Attributes  whose frame lies in the Visible Rect
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attribute in cache{
            if CGRectIntersectsRect(attribute.frame, rect){
                layoutAttributes.append(attribute)
            }
        }
        return layoutAttributes
    }
    
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let itemIndex = round(proposedContentOffset.y / (dragOffset))
        let yOffset = itemIndex * (collectionView?.bounds.height)!
        return CGPoint(x: 0, y: yOffset)
    }
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        // Logic that calculates the UICollectionViewLayoutAttributes of the item
        // and returns the UICollectionViewLayoutAttributes
        return UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
    }
    
}
