//
//  UIView+EmptyView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/22.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define rating kScreen_Width/375

@class DDXEmptyLbView, DDXEmptyOrderView, DDXEmptyBtnView, DDXEmptyLoadingView;
@interface UIView (EmptyView)

@property (nonatomic,strong) DDXEmptyLoadingView *loadingView;
- (void)beginLoading;
- (void)endLoading;
@property (nonatomic,strong) DDXEmptyLbView *emptyLbView;
@property (nonatomic,strong) DDXEmptyOrderView *emptyOrderView;
@property (nonatomic,strong) DDXEmptyBtnView *emptyBtnView;

- (void)showEmptyPageViewWithImage:(UIImage* )image
                               tip:(NSString* )tip
                       buttonTitle:(NSString *)title;

- (void)showEmptyPageViewWithImage:(UIImage* )image
                               tip:(NSString* )tip;

- (void)showEmptyOrderPageViewWithImage:(UIImage* )image
                                    tip:(NSString* )tip;

- (void)hideAllGeneralPage;

- (void)configReloadAction:(void(^)())block;

@end


/**************** 无按钮 *****************/
#pragma mark --- DDXEmptyLbView
@interface DDXEmptyLbView : UIView

- (instancetype)initWithImage:(UIImage* )image
                          tip:(NSString* )tip;

@end

/**************** 无按钮 订单页 *****************/
#pragma mark --- DDXEmptyOrderView
@interface DDXEmptyOrderView : UIView

- (instancetype)initWithOrderPlaceholderImage:(UIImage* )image
                                          tip:(NSString* )tip;

@end


/**************** 有按钮 *****************/
#pragma mark --- DDXEmptyBtnView
@interface DDXEmptyBtnView : UIView

- (instancetype)initWithImage:(UIImage* )image
                          tip:(NSString* )tip
                  buttonTitle:(NSString *)title;
@property (nonatomic,copy) void(^didClickActionBlock)();

@end


/**************** 加载中 *****************/
#pragma mark --- DDXEmptyLoadingView
@interface DDXEmptyLoadingView : UIView

@property (nonatomic,assign,readonly) BOOL isLoading;
- (void)startAnimation;
- (void)stopAnimation;

@end
