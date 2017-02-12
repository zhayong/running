//
//  HomePageViewController.m
//  Running
//
//  Created by Zhayong on 16/01/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "HomePageViewController.h"

#import "UserInfoModel.h"
#import "HealthDataManager.h"
#import "TimeManager.h"

#import <CoreMotion/CoreMotion.h>

@interface HomePageViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nickname;

@property (weak, nonatomic) IBOutlet UILabel *declartion;
@property (weak, nonatomic) IBOutlet UILabel *targetStepCount;
@property (weak, nonatomic) IBOutlet UILabel *realStepCount;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *points;


@property (nonatomic, strong) HealthDataManager *healthManager;
@property (nonatomic, strong) UserInfoModel *userInfo;
@property (nonatomic, strong) TimeManager *timeManger;
@property (nonatomic, strong) CMPedometer *cmPedometer;
@property (nonatomic, strong) NSDate *stepDate;

@property (nonatomic, assign) BOOL isSuccess;

@end

@implementation HomePageViewController

// 懒加载
-(UserInfoModel *)userInfo
{
    if(!_userInfo){
        _userInfo = [[UserInfoModel alloc]init];
    }
    return _userInfo;
}

-(TimeManager *)timeManger
{
    if(!_timeManger){
        _timeManger = [[TimeManager alloc]init];
    }
    return _timeManger;
}

- (CMPedometer *)cmPedometer {
    if (!_cmPedometer) {
        _cmPedometer = [[CMPedometer alloc] init];
    }
    return _cmPedometer;
}

- (HealthDataManager *)healthManager{
    if(!_healthManager){
        _healthManager = [[HealthDataManager alloc]init];
    }
    return _healthManager;
}

- (NSDate *)stepDate {
    if (!_stepDate) {
        NSDate *toDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        _stepDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:toDate]];
    }
    return _stepDate;
}

- (void)initData
{
    [self.userInfo loadData];
    
    _nickname.text = self.userInfo.nickname;
    _declartion.text = self.userInfo.declaration;
    
    _targetStepCount.text = [NSString stringWithFormat:@"%@ 步",self.userInfo.targetStepCout];
    
    _level.text = self.userInfo.level;
    _points.text = [NSString stringWithFormat:@"%@ 积分",self.userInfo.point];
}

#pragma mark -- LifeCircle ---
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _realStepCount.text = @"0 步";
    __weak typeof(self) weakSelf = self;
    [self.healthManager getAuthorizationWithHandle:^(BOOL isSuccess) {
        NSDate *current = [weakSelf.timeManger run_getDateFromString:[weakSelf.timeManger run_getCurrentDate] withFormatter:@"yyyy年MM月dd日"];
        weakSelf.isSuccess = isSuccess;
        
        NSDate *nextDay = [current dateByAddingTimeInterval:86400];
        
        [self p_getHealthData:StepType fromDate:current toDate:nextDay];
    }];
    
    if (![CMPedometer isStepCountingAvailable]) {
        NSLog(@"CMPedometer Error");
    }else{
     [self p_startUpdateCount];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo) name:USERINFO_UPDATE_NOTIFACATION object:nil];
    
        // Do any additional setup after loading the view.
}

- (void)updateUserInfo{
    
}

#pragma mark - Get Health Data
- (void)p_getHealthData:(ZYMotionType)motionType fromDate:(NSDate *)nowDay toDate:(NSDate *)nextDay {
    [self.healthManager getHealthCountFromDate:nowDay toDate:nextDay type:DayType motionType:motionType resultHandle:^(NSArray *datas, double mintue) {
        
        NSLog(@"%@ %f",datas,mintue);
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
        });
    }];
}

#pragma mark - Get Step Count
- (void)p_getStepCountFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    [self.cmPedometer queryPedometerDataFromDate:fromDate toDate:toDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }];
}

#pragma mark - Start Update Count
- (void)p_startUpdateCount {
    // 启动计步
    [self.cmPedometer startPedometerUpdatesFromDate:[self stepDate] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"-------pedometerData：%@",pedometerData);
            self.realStepCount.text = [NSString stringWithFormat:@"%@ 步",[pedometerData.numberOfSteps stringValue]];
            
            if([pedometerData.numberOfSteps integerValue] >= [self.userInfo.targetStepCout integerValue]){
                // 升级等级
                [self.userInfo levelUp];
                // 增加积分
                [self.userInfo addPoint];
            }
        
            });
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 监听方法
//- (void)updateUserInfo
//{
//    [self initData];
//}

@end
