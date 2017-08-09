//
//  NSObject+Cache.h
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/19.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>
/** cache comment*/
typedef NS_ENUM (NSInteger,SandboxCacheType){
    SandboxCacheType_list               = 0,
    SandboxCacheType_detail             = 1,
};

@interface NSObject (Cache)

@end
