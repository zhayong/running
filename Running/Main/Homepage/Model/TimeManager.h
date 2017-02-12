//
//  TimeManager.h
//  Running
//
//  Created by Zhayong on 07/02/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeManager : NSObject

- (NSString *)run_getCurrentDate;
- (NSString *)run_getCurrentTime;
- (NSString *)run_getCurrentDateWithFormatter:(NSString *)formatter;
- (NSString *)run_getDate:(NSDate *)date withFormatter:(NSString *)formatter;

- (NSDate *)run_getDateFromString:(NSString *)dateStr;
- (NSDate *)run_getDateFromString:(NSString *)dateStr withFormatter:(NSString *)formatter;

@end
