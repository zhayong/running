//
//  MessageViewController.m
//  Running
//
//  Created by Zhayong on 16/01/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION)]];
    //自定义导航左右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"单聊" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
    [rightButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.conversationListTableView.tableFooterView = [UIView new];
    
}

/**
 *重写RCConversationListViewController的onSelectedTableRow事件
 *
 *  @param conversationModelType 数据模型类型
 *  @param model                 数据模型
 *  @param indexPath             索引
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.userName =model.conversationTitle;
    conversationVC.title = model.conversationTitle;
//    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"会话";
}

/**
 *  退出登录
 *
 *  @param sender <#sender description#>
 */
- (void)leftBarButtonItemPressed:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [alertView show];
}

/**
 *  重载右边导航按钮的事件
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarButtonItemPressed:(id)sender
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =ConversationType_PRIVATE;
    conversationVC.targetId = @"1"; //这里模拟自己给自己发消息，您可以替换成其他登录的用户的UserId
    conversationVC.userName = @"测试1";
    conversationVC.title = @"自问自答";
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[RCIM sharedRCIM]disconnect];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
