//
//  NSDate+Comment.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/19.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateTools.h"

NS_ENUM(NSInteger,TimeValueType){
    ValueTypeOfSecondAgo = 0,
    ValueTypeOfMinuteAgo,
    ValueTypeOfHourAgo,
    ValueTypeOfDayAgo,
    ValueTypeOfWeekAgo,
    ValueTypeOfMonthAgo,
    ValueTypeOfYearAgo
};

@interface NSDate (Comment)

+ (instancetype)dateFromString:(NSString *)string;
- (NSString *)weekdayString;

- (NSString* )timeAgoSince;

@end
