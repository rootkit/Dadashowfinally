//
//  DDXConsignee.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/28.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DDXConsignee.h"

#define DDX_ConsigneeKey    @"consignee"
#define DDX_ProvinceKey     @"province"
#define DDX_CityKey         @"city"
#define DDX_DistrictKey     @"district"
#define DDX_MobileKey       @"mobile"

@implementation DDXConsignee

//保存默认地址
+ (void)saveUserDefaulrAddress:(DDXConsignee *)consignee
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:consignee.consignee forKey:DDX_ConsigneeKey];
    [defaults setObject:consignee.province forKey:DDX_ProvinceKey];
    [defaults setObject:consignee.city forKey:DDX_CityKey];
    [defaults setObject:consignee.district forKey:DDX_DistrictKey];
    [defaults setObject:consignee.mobile forKey:DDX_MobileKey];
    
    [defaults synchronize];
}

//取默认地址
+ (DDXConsignee *)loadUserDefaultAddress
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    DDXConsignee *consig = [DDXConsignee new];
    
    consig.consignee = [defaults objectForKey:DDX_ConsigneeKey];
    consig.province = [defaults objectForKey:DDX_ProvinceKey];
    consig.city = [defaults objectForKey:DDX_CityKey];
    consig.district = [defaults objectForKey:DDX_DistrictKey];
    consig.mobile = [defaults objectForKey:DDX_MobileKey];
    
    return consig;
}

//清除默认地址
+ (void)deleteUserDefaultAddress
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:DDX_ConsigneeKey];
    [defaults removeObjectForKey:DDX_ProvinceKey];
    [defaults removeObjectForKey:DDX_CityKey];
    [defaults removeObjectForKey:DDX_DistrictKey];
    [defaults removeObjectForKey:DDX_MobileKey];
}

@end
