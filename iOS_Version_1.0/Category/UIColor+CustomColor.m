//
//  UIColor+CustomColor.m
//  TestProject
//
//  Created by 李萍 on 2017/4/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)
    
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}
    
+ (UIColor *)colorWithHex:(int)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}
    
///
+ (UIColor *)themeColor
{
    return [UIColor colorWithHex:0xfc5c98];//0xf30867];
}

//星星颜色
+ (UIColor *)startOnColor
{
    return [UIColor colorWithHex:0xea8010];
}

+ (UIColor *)startOffColor
{
    return [UIColor colorWithHex:0x111111];
}


@end
