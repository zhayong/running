//
//  HealthDataManager.m
//  Running
//
//  Created by Zhayong on 07/02/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "HealthDataManager.h"
#import <HealthKit/HealthKit.h>

@interface HealthDataManager()

@property (nonatomic, strong) HKHealthStore *healthStore;

@end

@implementation HealthDataManager

- (instancetype)init {
    self = [super init];
    if (self) {
        if (![HKHealthStore isHealthDataAvailable]) {
            NSLog(@"设备不支持healthKit");
        }
        
        self.healthStore = [[HKHealthStore alloc] init];
    }
    return self;
}

#pragma mark - Get Authorization
- (void)getAuthorizationWithHandle:(ZYAuthorizationResult)handle {
    HKObjectType *stepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKObjectType *weightCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKObjectType *disCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKObjectType *flightsClimbedCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    HKObjectType *energyCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    NSSet *healthSet = [NSSet setWithObjects:stepCount, weightCount, disCount, flightsClimbedCount, energyCount, nil];
    
    NSSet *writeSet = [NSSet setWithObjects:weightCount, energyCount, nil];
    
    //从健康中获取权限
    [self.healthStore requestAuthorizationToShareTypes:writeSet readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
        handle(success);
    }];
}

#pragma mark - Motion Data
- (void)getHealthCountFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate type:(ZYDateType)type
                    motionType:(ZYMotionType)motionType resultHandle:(ZYDataBlock)handle {
    [self p_getHealthCountFromDate:fromDate toDate:toDate type:type motionType:motionType resultHandle:handle];
}

- (void)p_getHealthCountFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate type:(ZYDateType)type
                      motionType:(ZYMotionType)motionType resultHandle:(ZYDataBlock)handle{
    HKSampleType *motion = [self p_getMotionWithType:motionType];
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:fromDate endDate:toDate options:HKQueryOptionNone];
    
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:motion predicate:predicate limit:ULONG_MAX sortDescriptors:nil resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        if (results.count > 0) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            if (type == DayType) {
                dateFormatter.dateFormat = @"yyyy-MM-dd HH";
            } else if (type == WeekType || type == MonthType || type == NoneType) {
                dateFormatter.dateFormat = @"yyyy-MM-dd";
            } else {
                dateFormatter.dateFormat = @"yyyy-MM";
            }
            
            double count = 0;
            double mintue = 0;
            NSString *pre = [dateFormatter stringFromDate:[results firstObject].startDate];
            NSMutableArray *array = [NSMutableArray array];
            
            double allCount = 0;
            for (int index = 0; index < results.count;) {
                HKQuantitySample *obj = results[index];
                HKQuantity *quantity = obj.quantity;
                NSString *stepStr = [NSString stringWithFormat:@"%@", quantity];
                NSString *stepCount = [[stepStr componentsSeparatedByString:@" "] firstObject];
                mintue += [self p_getActivityTimeWithFirstTime:obj.startDate secondTime:obj.endDate];
                if ([pre isEqualToString:[dateFormatter stringFromDate:obj.startDate]]) {
                    count += [stepStr doubleValue];
                    index++;
                } else {
                    if (type == DayType) {
                        [array addObject:@{[[pre componentsSeparatedByString:@" "] lastObject] : @(count)}];
                    } else if(type == WeekType || type == MonthType) {
                        NSString *tempStr = [[pre componentsSeparatedByString:@" "] firstObject];
                        [array addObject:@{[[tempStr componentsSeparatedByString:@"-"] lastObject] : @(count)}];
                    } else if(type == YearType) {
                        NSString *tempStr = [[pre componentsSeparatedByString:@" "] firstObject];
                        NSArray *keys = [tempStr componentsSeparatedByString:@"-"];
                        NSString *keyStr = [NSString stringWithFormat:@"%@/%@", keys[0], keys[1]];
                        [array addObject:@{keyStr : @(count)}];
                    } else {
                        [array addObject:@{@"date" : [[pre componentsSeparatedByString:@" "] firstObject],
                                           @"value" : @(count)}];
                    }
                    
                    pre = [dateFormatter stringFromDate:obj.startDate];
                    count = 0;
                }
                
                allCount += [stepCount doubleValue];
            }
            
            if (type == DayType) {
                [array addObject:@{[[pre componentsSeparatedByString:@" "] lastObject] : @(count)}];
            } else if(type == WeekType || type == MonthType) {
                NSString *tempStr = [[pre componentsSeparatedByString:@" "] firstObject];
                [array addObject:@{[[tempStr componentsSeparatedByString:@"-"] lastObject] : @(count)}];
            } else if(type == YearType) {
                NSString *tempStr = [[pre componentsSeparatedByString:@" "] firstObject];
                NSArray *keys = [tempStr componentsSeparatedByString:@"-"];
                NSString *keyStr = [NSString stringWithFormat:@"%@/%@", keys[0], keys[1]];
                [array addObject:@{keyStr : @(count)}];
            } else {
                [array addObject:@{@"date" : [[pre componentsSeparatedByString:@" "] firstObject],
                                   @"value" : @(count)}];
            }
            
            handle(array, mintue);
        } else {
            handle(nil, 0);
        }
    }];
    
    [self.healthStore executeQuery:query];
}

- (HKSampleType *)p_getMotionWithType:(ZYMotionType)type {
    HKSampleType *motion = nil;
    switch (type) {
        case StepType:
            motion = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
            break;
        case DistanceType:
            motion = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
            break;
        default:
            break;
    }
    return motion;
}

- (CGFloat)p_getActivityTimeWithFirstTime:(NSDate *)firstDate secondTime:(NSDate *)secondDate {
    NSInteger second = [secondDate timeIntervalSinceDate:firstDate];
    double time = second / 60.0;
    
    return time;
}

@end
