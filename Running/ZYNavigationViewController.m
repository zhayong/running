//
//  ZYNavigationViewController.m
//  Running
//
//  Created by Zhayong on 03/02/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "ZYNavigationViewController.h"

@interface ZYNavigationViewController ()

@end

@implementation ZYNavigationViewController


/**
 *  第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTintColor:[UIColor whiteColor]];
//    _UINavigationBarBackIndicatorView
    // 设置背景
//    if (!iOS7) {
//        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
//    }
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    NSShadow *shadow = [[NSShadow alloc]init];
//    shadow.shadowOffset = CGSizeZero;
//    textAttrs[NSShadowAttributeName] = shadow;
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:iOS7 ? 14 : 12];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = iOS7 ? [UIColor orangeColor] : [UIColor grayColor];
//    NSShadow *shadow = [[NSShadow alloc]init];
//    shadow.shadowOffset = CGSizeZero;
//    textAttrs[NSShadowAttributeName] = shadow;
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:iOS7 ? 14 : 12];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
//    navBar.barTintColor = [UIColor lightGrayColor];
//    [navBar setBackIndicatorImage:[UIImage imageNamed:@"aperture"]];
//    [navBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"aperture"]];
    
    // 设置背景
//    if (!iOS7) {
//        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    }
    
    // 设置标题属性
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//    NSShadow *shadow = [[NSShadow alloc]init];
//    shadow.shadowOffset = CGSizeZero;
//    shadow.shadowBlurRadius = 0.f;
//    textAttrs[NSShadowAttributeName] = shadow;
//    textAttrs[NSShadowAttributeName] = shadow;
//    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19];
//    [navBar setTitleTextAttributes:textAttrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
