//
//  UIView+LPView.h
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/15.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface UIView (LPView)

@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

- (UIViewController *)parentController;

- (void)handleCornerRadiusWithRadius:(CGFloat)radius;

- (void)handleBoardWidth:(CGFloat)width andBorderColor:(UIColor *)color;

- (void)handleShadowOffset:(CGSize)size shadowColor:(UIColor *)color shadowOpacity:(CGFloat)opacity;

@end
