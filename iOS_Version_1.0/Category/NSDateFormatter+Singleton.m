//
//  NSDateFormatter+Singleton.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/19.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "NSDateFormatter+Singleton.h"

@implementation NSDateFormatter (Singleton)

+ (instancetype)sharedInstance
{
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSTimeZone *zone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        formatter.timeZone = zone;
    });
    
    return formatter;
}

@end
