//
//  TimeManager.m
//  Running
//
//  Created by Zhayong on 07/02/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "TimeManager.h"

@implementation TimeManager

#pragma mark - Date To String
- (NSString *)run_getCurrentDate {
    return [self run_getCurrentDateWithFormatter:@"yyyy年MM月dd日"];
}

- (NSString *)run_getCurrentTime {
    return [self run_getCurrentDateWithFormatter:@"HH:mm:ss"];
}

- (NSString *)run_getCurrentDateWithFormatter:(NSString *)formatter {
    NSDate *currentDate = [NSDate date];
    return [self run_getDate:currentDate withFormatter:formatter];
}

- (NSString *)run_getDate:(NSDate *)date withFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    dateFormatter.dateFormat = formatter;
    return [dateFormatter stringFromDate:date];
}

#pragma mark - String To Date
- (NSDate *)run_getDateFromString:(NSString *)dateStr {
    return [self run_getDateFromString:dateStr withFormatter:@"yyyy年MM月dd日 HH:mm:ss"];
}

- (NSDate *)run_getDateFromString:(NSString *)dateStr withFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    return [dateFormatter dateFromString:dateStr];
}


@end
