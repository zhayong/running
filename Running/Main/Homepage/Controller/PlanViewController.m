//
//  PlanViewController.m
//  Running
//
//  Created by Zhayong on 07/02/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "PlanViewController.h"

#import "UserInfoModel.h"

@interface PlanViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *stepCount;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (nonatomic, strong) NSArray *targetSteps;

@property (nonatomic, strong) UserInfoModel *userInfo;

@end

@implementation PlanViewController

//-(UserInfoModel *)userInfo{
//    if(!_userInfo){
//        _userInfo = [[UserInfoModel alloc]init];
//    }
//    return _userInfo;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userInfo = [UserInfoModel shareUserInfo];
    _targetSteps = @[@"6000",@"7000",@"8000",@"9000",@"10000",@"11000",@"12000"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _targetSteps.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@ 步",[_targetSteps objectAtIndex:row]] ;
}

#pragma mark-UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _stepCount.text = [NSString stringWithFormat:@"%@ 步",[_targetSteps objectAtIndex:row]];
    
    // 保存数据
    self.userInfo.targetStepCout = [_targetSteps objectAtIndex:row];
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
