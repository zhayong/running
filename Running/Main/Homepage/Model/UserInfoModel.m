//
//  UserInfoModel.m
//  Running
//
//  Created by Zhayong on 07/02/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "UserInfoModel.h"

@interface UserInfoModel ()

@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation UserInfoModel

+ (UserInfoModel *)shareUserInfo{
    static UserInfoModel *shareUserinfo = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareUserinfo = [[self alloc] init];
    });
    return shareUserinfo;
}

- (void)loadData {
    self.isLogin = [self.defaults objectForKey:@"isLogin"];
    self.nickname = [self.defaults objectForKey:@"nickname"];
    self.declaration = [self.defaults objectForKey:@"declaration"];
    self.profileImageName = [self.defaults objectForKey:@"profileImageName"];
    
    self.targetStepCout = [self.defaults objectForKey:@"targetStepCout"];
    self.point = [self.defaults objectForKey:@"point"];
    self.level = [self.defaults objectForKey:@"level"];
}

- (void)saveData {
    [self.defaults setObject:self.nickname forKey:@"nickname"];
    [self.defaults setObject:self.declaration forKey:@"declaration"];
    [self.defaults setObject:self.targetStepCout forKey:@"targetStepCout"];
    [self.defaults setObject:self.point forKey:@"point"];
    [self.defaults setObject:self.level forKey:@"level"];
    [self.defaults synchronize];
}

- (void)saveLoginStatus {
    [self.defaults setObject:self.isLogin forKey:@"isLogin"];
    [self.defaults synchronize];
}

- (void)levelUp{
    // 取出当前等级
    NSInteger oldLevel = [[[self.level componentsSeparatedByString:@"_"] lastObject] integerValue];
    // 新的等级
    NSInteger newLevel = oldLevel > LEVEL_COUNT ? LEVEL_COUNT : oldLevel + 1;
    
    self.level = [NSString stringWithFormat:@"LEVEL_%ld",(long)newLevel];
}

- (void)addPoint
{
    NSInteger newPoint = [self.point integerValue] + 1;
    
    self.point = [NSString stringWithFormat:@"%ld",(long)newPoint];
}

- (NSUserDefaults *)defaults {
    if (!_defaults) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return _defaults;
}

- (NSString *)profileImageName{
    if (!_profileImageName) {
        _profileImageName = @"profile";
    }
    return _profileImageName;
}

- (NSString *)nickname {
    if (!_nickname) {
        _nickname = @"Running用户";
    }
    return _nickname;
}

- (NSString *)declaration {
    if (!_declaration) {
        _declaration = @"生命在于运动！";
    }
    return _declaration;
}

- (NSString *)targetStepCout {
    if (!_targetStepCout) {
        _targetStepCout = @"10000";
    }
    return _targetStepCout;
}

- (NSString *)level {
    if (!_level) {
        _level = LEVEL_1;
    }
    return _level;
}

- (NSString *)point {
    if (!_point) {
        _point = @"0";
    }
    return _point;
}

- (NSString *)isLogin {
    if (!_isLogin) {
        _isLogin = @"NO";
    }
    return _isLogin;
}

@end
