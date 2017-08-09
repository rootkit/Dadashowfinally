//
//  BannerModel.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "BannerModel.h"
#import <objc/runtime.h>
@implementation BannerModel
- (void)setproperty:(NSDictionary *)dic
{
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        if (dic[name]) {
            [self setValue:dic[name] forKey:name];
        }
        
    }
    free(properties);
    
    
    
}
@end
