//
//  UIImageView+Dimage.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/25.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "UIImageView+Dimage.h"

@implementation UIImageView (Dimage)
- (void)setImageL {
    
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 4;
    [path moveToPoint:CGPointMake(0,0)];
    [path addLineToPoint:CGPointMake(kScreen_Width /4, 0)];
    [path addLineToPoint:CGPointMake(kScreen_Width/5, 200)];
    [path addLineToPoint:CGPointMake(0, 200)];
    [path closePath];
    CAShapeLayer * shapLayer = [CAShapeLayer layer];
    shapLayer.lineWidth = 2;
    shapLayer.path = path.CGPath;
    self.layer.mask = shapLayer;
}

- (void)setimageH {
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 4;
    [path moveToPoint:CGPointMake(kScreen_Width /4, 0)];
    [path addLineToPoint:CGPointMake(3*kScreen_Width/7, 0)];
    [path addLineToPoint:CGPointMake(kScreen_Width/2, 200)];
    [path addLineToPoint:CGPointMake(kScreen_Width/5, 200)];
    [path closePath];
    CAShapeLayer * shapLayer = [CAShapeLayer layer];
    shapLayer.lineWidth = 2;
    shapLayer.path = path.CGPath;
    self.layer.mask = shapLayer;
    
}



- (void)setimageT{
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 4;
    [path moveToPoint:CGPointMake(3*kScreen_Width/7, 0)];
    [path addLineToPoint:CGPointMake(3*kScreen_Width/4, 0)];
    [path addLineToPoint:CGPointMake(kScreen_Width/2+kScreen_Width/5, 200)];
    [path addLineToPoint:CGPointMake(kScreen_Width/2, 200)];
    [path closePath];
    CAShapeLayer * shapLayer = [CAShapeLayer layer];
    shapLayer.lineWidth = 2;
    shapLayer.path = path.CGPath;
    self.layer.mask = shapLayer;
    
}

- (void)setimageF{
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 4;
    [path moveToPoint:CGPointMake(kScreen_Width, 0)];
    [path addLineToPoint:CGPointMake(3*kScreen_Width/4, 0)];
    [path addLineToPoint:CGPointMake(kScreen_Width/2+kScreen_Width/5, 200)];
    [path addLineToPoint:CGPointMake(kScreen_Width, 200)];
    [path closePath];
    CAShapeLayer * shapLayer = [CAShapeLayer layer];
    shapLayer.lineWidth = 2;
    shapLayer.path = path.CGPath;
    self.layer.mask = shapLayer;
    
}




@end
