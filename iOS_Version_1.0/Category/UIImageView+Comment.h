//
//  UIImageView+Comment.h
//  iosapp
//
//  Created by Graphic-one on 16/11/30.
//  Copyright © 2016年 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Comment)

@end



/** using runtime save bitmap */
@interface UIImageView (CornerRadius)

- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (void)zy_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (instancetype)initWithRoundingRectImageView;

- (void)zy_cornerRadiusRoundingRect;

- (void)zy_attachBorderWidth:(CGFloat)width color:(UIColor *)color;

@end


/** using 'shouldRasterize' handle */
@interface UIImageView (RadiusHandle)

- (void)addCorner:(CGFloat)radius;

- (void)handleCornerRadiusWithRadius:(CGFloat)radius;///使用光栅化

- (void)handleBoardWidth:(CGFloat)width andBorderColor:(UIColor *)color;

@end


/** 使用SDWebImage赋值图片并提供默认占位 */
@interface UIImageView (PortraitImage)

//用户头像
- (void)loadPortrait:(NSURL *)portraitURL;
//图片
- (void)loadPicture:(NSURL *)imageUrl;

@end






