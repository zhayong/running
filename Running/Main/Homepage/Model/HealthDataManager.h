//
//  HealthDataManager.h
//  Running
//
//  Created by Zhayong on 07/02/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZYAuthorizationResult)(BOOL isSuccess);
typedef void(^ZYNSaveDataBlock)(BOOL isSuccess, NSError *error);
typedef void(^ZYDataBlock)(NSArray *datas, double mintue);

typedef enum : NSUInteger {
    DayType = 0,
    WeekType,
    MonthType,
    YearType,
    NoneType
} ZYDateType;

typedef enum : NSUInteger {
    StepType = 0,
    DistanceType,
} ZYMotionType;

@interface HealthDataManager : NSObject

- (void)getAuthorizationWithHandle:(ZYAuthorizationResult)handle;

- (void)getHealthCountFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate type:(ZYDateType)type
                    motionType:(ZYMotionType)motionType resultHandle:(ZYDataBlock)handle;

@end
