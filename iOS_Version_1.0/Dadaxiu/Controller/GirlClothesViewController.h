//
//  GirlClothesViewController.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GirlClothesViewController : UIViewController

- (instancetype)initWithActivityType:(ActivityTypes)activityType
                          withBanner:(UIImage *)bannerImg
                           withTitle:(NSString *)title
                 withBannerGoodsType:(NSString *)bannerGoodsType;

@end
