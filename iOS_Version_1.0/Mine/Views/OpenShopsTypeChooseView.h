//
//  OpenShopsTypeChooseView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/5.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OpenShopsTypeChooseBoardDelegate <NSObject>

- (void)selectedShopType:(NSString *)typeTitle;

@end

@interface OpenShopsTypeChooseBoard : NSObject

+ (instancetype)popViewManager;
- (void)showPopView;
- (void)hiddenPopView;

@property (nonatomic, weak) id <OpenShopsTypeChooseBoardDelegate> delegate;

@end

//////////

@protocol OpenShopsTypeChooseViewDelegate <NSObject>

- (void)selectedShopType:(NSString *)typeTitle;

@end

@interface OpenShopsTypeChooseView : UIView

@property (nonatomic, weak) IBOutlet UIView *bgView;
@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, weak) id <OpenShopsTypeChooseViewDelegate> delegate;

+ (instancetype)showCouponPopView;

@end
