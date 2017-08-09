//
//  Searcharray.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/24.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Searcharray : NSObject

@property(nonatomic,strong)NSMutableArray *searcharray;
+(Searcharray*)sharedarray;

+ (void)deallocarray;
@end
