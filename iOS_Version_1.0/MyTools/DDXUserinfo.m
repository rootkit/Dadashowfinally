//
//  DDXUserinfo.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/1.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DDXUserinfo.h"

@implementation DDXUserinfo
#define DDxIDKey               @"userID"       // 搭搭秀ID
#define DDxPhoneNumKey         @"phoneNum"     // 手机号
#define DDxUserCodeKey         @"code"         //唯一标识符
#define DDxUserPasswordKey     @"password"     //密码

#define DDxAliasKey            @"alias" //昵称
#define DDxVisitCountKey       @"visitCount" //登录次数
#define DDxPersonalityKey      @"personality" //个性描述
#define DDxSexKey              @"sex" //性别
#define DDxHeaderUrlKey        @"headerUrl" //用户头像
#define DDxUserMartUrlKey      @"martUrl"      //二维码图片地址
//收货地址

#define DDxAddressDetailKey @"address" //具体地址
#define DDxAddressProvinceKey @"province" //省级
#define DDxAddressCityKey @"city" //市级
#define DDxAddressDistrictKey @"district" //区

#define DDxAddressIsDefaultKey @"isDefault" //是否为地址
#define DDxAddressIDKey @"addressId" //地址id


static DDXUserinfo *userInfo = nil;
static dispatch_once_t onceToken;
+ (DDXUserinfo *)sharedDWUserInfo;{
    dispatch_once(&onceToken, ^{
        userInfo = [[DDXUserinfo alloc] init];
    });
    return userInfo;
}


//销毁单利
+ (void)deallocDWUserInfo
{
    if (userInfo) {
        userInfo = nil;
        onceToken = 0;
    }
}

/*
//赋值键
- (void)saveUserInfoToSanbox
{
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    
    [defualts setObject:self.alias forKey:DDxAliasKey];
    [defualts setObject:@(self.visitCount) forKey:DDxVisitCountKey];
    [defualts setObject:self.mobile forKey:DDxPhoneNumKey];
    [defualts setObject:self.code forKey:DDxUserCodeKey];
    [defualts setObject:self.personality forKey:DDxPersonalityKey];
    
    [defualts setObject:@(self.sex) forKey:DDxSexKey];
    [defualts setObject:self.headerUrl forKey:DDxHeaderUrlKey];
    [defualts setObject:self.martUrl forKey:DDxUserMartUrlKey];
    [defualts setObject:@(self.Id) forKey:DDxIDKey];
    
    [defualts synchronize];
}

//取
- (void)loadUserInfoFromSanbox
{
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    
    self.alias = [defualts objectForKey:DDxAliasKey];
    self.visitCount = [[defualts objectForKey:DDxVisitCountKey] integerValue];
    self.mobile = [defualts objectForKey:DDxPhoneNumKey];
    self.code = [defualts objectForKey:DDxUserCodeKey];
    self.personality = [defualts objectForKey:DDxPersonalityKey];
    
    self.sex = [[defualts objectForKey:DDxSexKey] integerValue];
    self.headerUrl = [defualts objectForKey:DDxHeaderUrlKey];
    self.martUrl = [defualts objectForKey:DDxUserMartUrlKey];
    self.Id = [[defualts objectForKey:DDxIDKey] longValue];
}
*/
//赋值键
+ (void)saveUserInfoToSanbox:(DDXUserinfo *)userInfo
{
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    
    [defualts setObject:userInfo.alias forKey:DDxAliasKey];
    [defualts setObject:@(userInfo.visitCount) forKey:DDxVisitCountKey];
    [defualts setObject:userInfo.mobile forKey:DDxPhoneNumKey];
    [defualts setObject:userInfo.code forKey:DDxUserCodeKey];
    [defualts setObject:userInfo.personality forKey:DDxPersonalityKey];
    
    [defualts setObject:@(userInfo.sex) forKey:DDxSexKey];
    [defualts setObject:userInfo.headerUrl forKey:DDxHeaderUrlKey];
    [defualts setObject:userInfo.martUrl forKey:DDxUserMartUrlKey];
    [defualts setObject:@(userInfo.id) forKey:DDxIDKey];
    
    [defualts synchronize];
}

//取
+ (DDXUserinfo *)loadUserInfoFromSanbox
{
    DDXUserinfo *userInfo = [DDXUserinfo new];
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    
    userInfo.alias = [defualts objectForKey:DDxAliasKey];
    userInfo.visitCount = [[defualts objectForKey:DDxVisitCountKey] integerValue];
    userInfo.mobile = [defualts objectForKey:DDxPhoneNumKey];
    userInfo.code = [defualts objectForKey:DDxUserCodeKey];
    userInfo.personality = [defualts objectForKey:DDxPersonalityKey];
    
    userInfo.sex = [[defualts objectForKey:DDxSexKey] integerValue];
    userInfo.headerUrl = [defualts objectForKey:DDxHeaderUrlKey];
    userInfo.martUrl = [defualts objectForKey:DDxUserMartUrlKey];
    userInfo.id = [[defualts objectForKey:DDxIDKey] longValue];
    
    return userInfo;
}

//存默认地址
+ (void)saveUserAddressFromSanbox:(DDXUserAddress *)address
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:address.address forKey:DDxAddressDetailKey];
    [defaults setObject:address.province forKey:DDxAddressProvinceKey];
    [defaults setObject:address.city forKey:DDxAddressCityKey];
    [defaults setObject:address.district forKey:DDxAddressDistrictKey];
    
    [defaults setObject:@(address.isDefault) forKey:DDxAddressIsDefaultKey];
    [defaults setObject:@(address.id) forKey:DDxAddressIDKey];
}

+ (DDXUserAddress *)getAddressFromSanbox
{
    DDXUserAddress *address = [DDXUserAddress new];
    
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    address.address = [defualts objectForKey:DDxAddressDetailKey];
    address.province = [defualts objectForKey:DDxAddressProvinceKey];
    address.city = [defualts objectForKey:DDxAddressCityKey];
    address.district = [defualts objectForKey:DDxAddressDistrictKey];
    
    address.isDefault = [[defualts objectForKey:DDxAddressIsDefaultKey] integerValue];
    address.id = [[defualts objectForKey:DDxAddressIDKey] longValue];
    
    return address;
}

//删除
- (void)deleteUserInfoFromSanbox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:DDxAliasKey];
    [defaults removeObjectForKey:DDxVisitCountKey];
    [defaults removeObjectForKey:DDxPhoneNumKey];
    [defaults removeObjectForKey:DDxUserCodeKey];
    [defaults removeObjectForKey:DDxPersonalityKey];
    
    [defaults removeObjectForKey:DDxSexKey];
    [defaults removeObjectForKey:DDxHeaderUrlKey];
    [defaults removeObjectForKey:DDxUserMartUrlKey];
    [defaults removeObjectForKey:DDxIDKey];

    [DDXUserinfo deallocDWUserInfo];

}

//获取用户唯一标识符
+ (NSString *)getUserCode
{
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    
    return [defualts objectForKey:DDxUserCodeKey];
}

//获取用户id
+ (long)getUserId
{
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    
    return [[defualts objectForKey:DDxIDKey] longValue];
}

@end



@implementation DDXUserAddress

@end
