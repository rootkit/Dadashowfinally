//
//  UIColor+CustomColor.h
//  TestProject
//
//  Created by 李萍 on 2017/4/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CustomColor)
    
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hexValue;

    
+ (UIColor *)themeColor;
+ (UIColor *)startOnColor;
+ (UIColor *)startOffColor;

@end
