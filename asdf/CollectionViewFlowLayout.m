//
//  CollectionViewFlowLayout.m
//  asdf
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CollectionViewFlowLayout.h"

@implementation CollectionViewFlowLayout
-(instancetype)init{
    if (self = [super init]) {
        //
        self.sectionInset = UIEdgeInsetsMake(100, 50, 100, 50);
        self.itemSize = CGSizeMake(100, 100);
        self.minimumInteritemSpacing = 30;
        self.minimumLineSpacing = 30;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
    }
    return self;
}



-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    //立体布局
    //    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    //    CGRect visibleRect;
    //    visibleRect.origin = self.collectionView.contentOffset;
    //    visibleRect.size = self.collectionView.bounds.size;
    //    float collectionViewHalfFrame = self.collectionView.frame.size.width/2.0f;
    //
    //    for (UICollectionViewLayoutAttributes* attributes in array) {
    //        if (CGRectIntersectsRect(attributes.frame, rect)) {
    //            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
    //            CGFloat normalizedDistance = distance / collectionViewHalfFrame;
    //            if (ABS(distance) < collectionViewHalfFrame) {
    //                CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
    //                CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    //                rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    //                rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, (normalizedDistance) * M_PI_4, 0.0f, 1.0f, 0.0f);
    //                CATransform3D zoomTransform = CATransform3DMakeScale(zoom, zoom, 1.0);
    //                attributes.transform3D = CATransform3DConcat(zoomTransform, rotationAndPerspectiveTransform);
    //                attributes.zIndex = ABS(normalizedDistance) * 10.0f;
    //                CGFloat alpha = (1 - ABS(normalizedDistance)) + 0.1;
    //                if(alpha > 1.0f) alpha = 1.0f;
    //                attributes.alpha = alpha;
    //            } else {
    //
    //                attributes.alpha = 0.0f;
    //            }
    //        }
    //    }
    //    return array;
    
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    return array;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    //    self.itemSize = attributes.frame.size;
    //    attributes.center = CGPointMake(attributes.center.x, self.listCenter.y)
    return  attributes;
}

@end
