//
//  ZYPhonePickerView.m
//  Running
//
//  Created by Zhayong on 20/03/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#define IMAGE_SIZE (SCREEN_WIDTH - 60)/4

#import "ZYPhonePickerView.h"

@implementation ZYPhonePickerView

- (NSMutableArray *)imageViews{
    if (!_imageViews) {
        _imageViews = [[NSMutableArray alloc]init];
    }
    return _imageViews;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, IMAGE_SIZE + 20);
        
        _addImage = [UIImage imageNamed:@"addPic"];
        NSMutableArray * images = [NSMutableArray arrayWithObjects:_addImage, nil];
        [self setSelectedImages:images];
    }
    return self;
}
- (void)setSelectedImages:(NSMutableArray *)selectedImages{
    _rowCount = 1;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_selectedImages removeAllObjects];
    [_selectedImages addObjectsFromArray:selectedImages];
    int j = 0;
    for (int i = 1; i < selectedImages.count + 1; i ++) {
        if (i >= 10)          return;
        if (i % (4*_rowCount + 1) == 0){
            _rowCount ++;
            j = 0;
            self.frame = CGRectMake(0, 85, SCREEN_WIDTH, (IMAGE_SIZE + 10) * _rowCount);
            self.reloadTableViewBlock();
        }
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15 + (IMAGE_SIZE + 10) * j, (_rowCount - 1) * (IMAGE_SIZE + 10), IMAGE_SIZE, IMAGE_SIZE);
        button.tag = i ;
        [button setBackgroundImage:selectedImages[i - 1] forState:UIControlStateNormal];
        [self addSubview:button];
        [self.imageViews addObject:button];
        j ++;
    }
}
@end
