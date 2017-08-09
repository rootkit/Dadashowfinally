//
//  DDXHomeModel.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/19.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DDXHomeModel.h"

@implementation DDXHomeModel

@end

//

@implementation DDXPlateModel

@end

@implementation DDXSortModel

@end

@implementation DDXSearchModel

@end


@implementation Brandsselectarray
+ (instancetype)sharedArray{
    
    static Brandsselectarray *item = nil;
    static dispatch_once_t predicate ;
    if (!item) {
        dispatch_once(&predicate, ^{
            item = [[Brandsselectarray alloc]init];
            
        });
    }
    return item;
}

@end


@implementation Carcenter
+ (Carcenter*)sharedCount{
    
    static Carcenter *item = nil;
    static dispatch_once_t predicate ;
    if (!item) {
        dispatch_once(&predicate, ^{
            item = [[Carcenter alloc]init];
            
        });
    }
    return item;
}

@end

@implementation Tammytangs
+ (Tammytangs*)sharedTcount{
    
    static Tammytangs *item = nil;
    static dispatch_once_t predicate ;
    if (!item) {
        dispatch_once(&predicate, ^{
            item = [[Tammytangs alloc]init];
            
        });
    }
    return item;
}

@end


/************ 商品列表数据 ***********/

@implementation DDXGoodsModel

@end






