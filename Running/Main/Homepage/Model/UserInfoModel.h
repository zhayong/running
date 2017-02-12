//
//  UserInfoModel.h
//  Running
//
//  Created by Zhayong on 07/02/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, copy) NSString *profileImageName;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *declaration;

@property (nonatomic, copy) NSString *targetStepCout;

@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *point;

@property (nonatomic, copy) NSString *isLogin;

+ (UserInfoModel *)shareUserInfo;
- (void)loadData;
- (void)saveData;
- (void)saveLoginStatus;

- (void)levelUp;
- (void)addPoint;

@end
