//
//  PointsMallCollectionViewCell.h
//  Running
//
//  Created by Zhayong on 19/01/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PointsMallCollectionViewCell;

@protocol PointsMallCollectionViewCellDelegete <NSObject>

- (void)selectPointsMallCollectionViewCell:(PointsMallCollectionViewCell *)pointsMallCollectionViewCell;

@end


@interface PointsMallCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id<PointsMallCollectionViewCellDelegete>PointsMallCollectionViewCellDelegete;
@end
