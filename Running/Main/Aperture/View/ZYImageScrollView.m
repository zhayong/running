//
//  ZYImageScrollView.m
//  Running
//
//  Created by Zhayong on 20/03/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "ZYImageScrollView.h"

@implementation ZYImageScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH + 20, SCREEN_HEIGHT - 64);
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = YES;
    self.backgroundColor = [UIColor blackColor];
}

@end
