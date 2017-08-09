//
//  Searcharray.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/24.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "Searcharray.h"

@implementation Searcharray

static Searcharray *item = nil;
static dispatch_once_t predicate ;
+(Searcharray*)sharedarray
{
    if (!item) {
        dispatch_once(&predicate, ^{
            item = [[Searcharray alloc]init];
            
        });
    }
    return item;
}

//销毁单利
+ (void)deallocarray
{
    if (item) {
        item = nil;
        predicate = 0;
    }
}


@end
