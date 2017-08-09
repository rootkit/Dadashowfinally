//
//  DDXGoodsOrderModel.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/28.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 订单列表model ****/
#import <Foundation/Foundation.h>
#import "DDXShopCartGoods.h"

@interface DDXGoodsOrderModel : NSObject

@property (nonatomic, copy) NSString *orderNo;//主订单号
@property (nonatomic, assign) NSInteger buyerId; //买家 ID
@property (nonatomic, copy) NSString *orderNote;//订单备注
@property (nonatomic, copy) NSString *tradeOrderDate; //下单日期 yyyy-MM-dd HH:mm:ss
@property (nonatomic, assign) NSInteger paymentTypeId; //支付方式 id，外键
@property (nonatomic, copy) NSString *paymentType;//支付方式

@property (nonatomic, assign) NSInteger orderTotalAmount; //订单总金额
@property (nonatomic, assign) NSInteger orderDiscount; //订单优惠金额
@property (nonatomic, assign) NSInteger integral; //消费积分值
@property (nonatomic, assign) NSInteger actualAmount; //实际支付金额
@property (nonatomic, assign) NSInteger orderConsigneeId; //收件人 id
@property (nonatomic, copy) NSString *orderStatusKey;//订单状态值
@property (nonatomic, copy) NSString *orderStatus;//订单状态值
@property (nonatomic, assign) NSInteger buyNow; //是否一键购买,0:否，1:是

@property (nonatomic, strong) NSArray <DDXShopCartGoods *> *items;


@end
