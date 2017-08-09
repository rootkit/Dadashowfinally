//
//  DDXConsignee.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/28.
//  Copyright © 2017年 李萍. All rights reserved.
//

/** 收件人 **/
#import <Foundation/Foundation.h>

@interface DDXConsignee : NSObject

@property (nonatomic, copy) NSString *consignee; //收货人的姓名
@property (nonatomic, assign) NSInteger provinceId; //省份 ID
@property (nonatomic, copy) NSString *province; //收货人的省份
@property (nonatomic, assign) NSInteger cityId; //城市 ID
@property (nonatomic, copy) NSString *city; //收货人的城市

@property (nonatomic, assign) NSInteger districtId; //地区 ID
@property (nonatomic, copy) NSString *district; //收货人的地区
@property (nonatomic, copy) NSString *address;  //收货人的详细地址
@property (nonatomic, copy) NSString *zipcode;  //收货人的邮编
@property (nonatomic, copy) NSString *tel;  //收货人的电话
@property (nonatomic, copy) NSString *mobile;   //收货人的手机
@property (nonatomic, copy) NSString *email;    //收货人的邮箱

@property (nonatomic, copy) NSString *bestTime; //最佳收货时间
@property (nonatomic, assign) NSInteger id; //联系人 id，无此字段代表新增，否则代表修改

@property (nonatomic, copy) NSString *country; //收货人的国家，默认 CN
@property (nonatomic, assign) NSInteger userId; //买家 id
@property (nonatomic, assign) ConsigneeAddressType isDefault; //是否默认，1 默认，0 不是默认 默认值是 0

//保存默认地址
+ (void)saveUserDefaulrAddress:(DDXConsignee *)consignee;

//取默认地址
+ (DDXConsignee *)loadUserDefaultAddress;

//清除默认地址
+ (void)deleteUserDefaultAddress;

@end
