//
//  PointsMallCollectionViewCell.m
//  Running
//
//  Created by Zhayong on 19/01/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "PointsMallCollectionViewCell.h"

@implementation PointsMallCollectionViewCell

- (IBAction)exchange:(UIButton *)sender {
    [self.PointsMallCollectionViewCellDelegete selectPointsMallCollectionViewCell:self];
}

@end
