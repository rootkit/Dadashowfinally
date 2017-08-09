//
//  ConfirmOrderViewController.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDXShopCartGoods.h"

@interface ConfirmOrderViewController : UIViewController

- (instancetype)initWithSelectedGoods:(NSArray <DDXShopCartGoods *> *)goods withAllPrice:(float)allPrice; //从购物车进

- (instancetype)initWithDetailGoods:(DDXShopCartGoods *)goods;  //从详情进


@end
