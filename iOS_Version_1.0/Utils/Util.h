//
//  Util.h
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/18.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "NSTextAttachment+Util.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface Util : NSObject

/* 加密 */
+ (NSString *)sha1:(NSString *)input;

/* 渐变色（横向）*/
+ (CAGradientLayer *)layerForCycleScrollViewTitle:(UIView *)bottomView withLeftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor;

/* 检测是否为手机号 */
+ (BOOL)validateMobile:(NSString *)mobileNum;

/* 字符串处理 文字大小不同 */
+ (NSMutableAttributedString *)changeStringType:(NSString *)typeString
                                      withPrice:(NSString *)priceStr
                                   withTypeFont:(UIFont *)typeFont
                                  withPriceFont:(UIFont *)priceFont
                                     withReturn:(BOOL)isEnter;
/* 字符串处理 文字前后颜色不同 */
+ (NSMutableAttributedString *)changeAttributedStrWithfrontStr:(NSString *)frontStr
                                                 withBehindStr:(NSString *)behindStr
                                                withFrontColor:(UIColor *)frontColor
                                               withBehindColor:(UIColor *)behindColor;

/* 数组进行排序区标题（按字母A~Z） */
+ (NSMutableArray *)indexTitleWithArray:(NSArray *)array;

/* 数组进行排序数组嵌数组（按字母A~Z分区数组） */
+ (NSMutableArray *)arrayWithArray:(NSArray *)array;

/* 数组进行排序区标题（按字母A~Z） 联系人列表*/
+ (NSMutableArray *)indexPhoneNumerAndNameWithDic:(NSArray *)array;
/* 数组进行排序数组嵌数组（按字母A~Z分区数组） 联系人列表 */
+ (NSMutableArray *)dicPhoneNumerAndNameWithWithArray:(NSArray *)array;

//拼接字符串和图标
+ (NSMutableAttributedString *)jointStringWithIcon:(NSString *)string iconName:(NSString *)iconName;

+ (MBProgressHUD *)createHUD;

//数据json组装，先BASE64Encoder，然后倒序，再URLEncoder
+ (NSString *)jsonBase64AndUrlEncoder:(NSString *)dic;
//数据解码
+ (NSString *)jsonDecodeBase64AndUrlEncoder:(NSString *)decodeStr;



/**
 @brief 弹窗
 @param title 弹窗标题
 message 弹窗信息
 */
+ (void) showAlertView: (NSString*) title andMessage: (NSString *) message;

/**
 *  弹窗
 *
 *  @param title    弹窗标题
 *  @param message  弹窗信息
 *  @param delegate 弹窗代理
 */
+ (void) showAlertView: (NSString*) title
            andMessage: (NSString *) message
          withDelegate: (UIViewController<UIAlertViewDelegate> *) delegate;


//字典转json格式字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
//把json字符串转换为Json对象的方法

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;


@end
