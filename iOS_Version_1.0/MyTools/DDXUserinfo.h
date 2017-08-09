//
//  DDXUserinfo.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/1.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ENUM_LIST.h"
#import "DDXConsignee.h"

@class DDXUserAddress;
@interface DDXUserinfo : NSObject
// 注册返回信息......
//@property (nonatomic, copy) NSString *mobile; // 手机号
//@property (nonatomic, assign) long id;     //搭搭秀ID
//@property (nonatomic, copy) NSString *code;     //搭搭秀code
//@property (nonatomic, copy) NSString *martUrl; //二维码图片地址
//@property (nonatomic, copy) NSString *password;//密码

@property (nonatomic, copy) NSString *alias;   //昵称
@property (nonatomic, assign) NSInteger visitCount;     //登录次数
@property (nonatomic, copy) NSString *mobile; // 手机号
@property (nonatomic, copy) NSString *code;     //搭搭秀code
@property (nonatomic, copy) NSString *personality;     //个性描述

@property (nonatomic, assign) UserSexType sex;     //性别
@property (nonatomic, copy) NSString *headerUrl; //用户头像
@property (nonatomic, copy) NSString *martUrl; //二维码图片地址
@property (nonatomic, assign) long id;     //搭搭秀ID
@property (nonatomic, strong) DDXUserAddress *orderConsignee; //收货地址


//搭搭秀秀ID// 登录返回的信息........


+(DDXUserinfo *)sharedDWUserInfo;

+ (void)deallocDWUserInfo;
/*
- (void)loadUserInfoFromSanbox;
- (void)saveUserInfoToSanbox;
*/

- (void)deleteUserInfoFromSanbox;

//存
+ (void)saveUserInfoToSanbox:(DDXUserinfo *)userInfo;
//取
+ (DDXUserinfo *)loadUserInfoFromSanbox;
//获取用户唯一标识符
+ (NSString *)getUserCode;
//获取用户id
+ (long)getUserId;

@end


@interface DDXUserAddress : NSObject

@property (nonatomic, copy) NSString *address; //具体地址
@property (nonatomic, copy) NSString *province;//省级
@property (nonatomic, copy) NSString *city;//市级
@property (nonatomic, copy) NSString *district;//区

@property (nonatomic, assign) NSInteger isDefault;//是否默认收货地址
@property (nonatomic, assign) long id;//地址id

@end
