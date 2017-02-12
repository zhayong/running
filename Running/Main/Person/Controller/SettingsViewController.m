//
//  SettingsViewController.m
//  Running
//
//  Created by Zhayong on 19/01/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "SettingsViewController.h"

#import "UserInfoModel.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (weak, nonatomic) IBOutlet UITextView *declaration;

@property (nonatomic, strong) UserInfoModel *userInfo;

@end

@implementation SettingsViewController

//-(UserInfoModel *)userInfo{
//    if(!_userInfo){
//        _userInfo = [[UserInfoModel alloc]init];
//    }
//    return _userInfo;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [UserInfoModel shareUserInfo];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Button Response

- (IBAction)save:(UIButton *)sender {
    self.userInfo.nickname = _nickname.text;
    self.userInfo.declaration = _declaration.text;
    
    [self.userInfo saveData];
    
//    // 刷新主页用户信息
//    [[NSNotificationCenter defaultCenter] postNotificationName:USERINFO_UPDATE_NOTIFACATION object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
