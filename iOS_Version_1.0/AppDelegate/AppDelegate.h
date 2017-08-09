//
//  AppDelegate.h
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/14.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, assign) BOOL isHiddenLoadView;

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)void(^clickblock)(NSInteger selectedindex);
- (void)setTabbarSubviews;
@end

