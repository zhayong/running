//
//  ZYEditImageViewController.h
//  Running
//
//  Created by Zhayong on 20/03/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYImageScrollView.h"

#define IMAGE_HEIHT SCREEN_WIDTH * image.size.height/image.size.width

@interface ZYEditImageViewController : UIViewController <UIScrollViewDelegate>

/** 图片*/
@property(nonatomic,strong)NSMutableArray *images;
/** 当前位置*/
@property(nonatomic,assign)int currentOffset;
/** 部分刷新*/
@property(nonatomic,copy)void(^reloadBlock)(NSMutableArray *);

@end
