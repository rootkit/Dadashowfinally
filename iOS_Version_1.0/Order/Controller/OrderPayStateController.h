//
//  OrderPayStateController.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/14.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPayStateController : UIViewController

- (instancetype)initWithPayState:(BOOL)isSuccess withConsigNee:(DDXConsignee *)consignee withPrice:(float)price;

@end
