//
//  WaitPayViewController.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DDXGoodsOrderModel.h"
#import "DDXConsignee.h"

@interface WaitPayViewController : UIViewController

- (instancetype)initWithOrderInfo:(DDXGoodsOrderModel *)goodsOrder withAddress:(DDXConsignee *)consignee;

@end
