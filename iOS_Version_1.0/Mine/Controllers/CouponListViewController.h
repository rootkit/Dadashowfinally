//
//  CouponListViewController.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/20.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CouponListType)
{
    CouponListTypeForShops = 1,
    CouponListTypeForCash,
};

@interface CouponListViewController : UITableViewController

- (instancetype)initWithCouponListType:(CouponListType)type;

@end
