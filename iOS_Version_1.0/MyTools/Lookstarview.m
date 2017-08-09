//
//  Lookstarview.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "Lookstarview.h"
#import "UIColor+CustomColor.h"
//星星间距
#define starSpace  8
#define WS  __weak __typeof(self)weakSelf = self;
@interface Lookstarview ()
@property (nonatomic, assign) CGFloat starWidth;
@property (nonatomic, assign) CGFloat starAndSpace;
@property (nonatomic, assign) CGFloat touchX;
@end
@implementation Lookstarview
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setNeedsDisplay];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
// 手势点击时评分动态变化
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:self];
    NSLog(@"点击%f",touchPoint.x);
    int t = (int)(touchPoint.x / self.starAndSpace);
    float f = (touchPoint.x - t * starSpace - t * self.starWidth) / self.starWidth;
    f = f>1.0?1.0:f;
    self.currentValue = t + f;
    
    self.touchX = touchPoint.x;
    [self setNeedsDisplay];
    
    return YES;
}

// 手势移动是评分动态变化
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:self];
    NSLog(@"滑动%f",touchPoint.x);
    // 防止越界
    if (touchPoint.x >= self.frame.size.width) {
        touchPoint.x = self.frame.size.width;
    }
    
    if (touchPoint.x <= 0) {
        touchPoint.x = 0;
    }
    
    //根据拖动的位置计算出分数
    int t = (int)(touchPoint.x / self.starAndSpace);
    float f = (touchPoint.x - t * starSpace - t * self.starWidth) / self.starWidth;
    f = f > 1.0 ? 1.0 : f;
    self.currentValue = t + f;
    
    self.touchX = touchPoint.x;
    [self setNeedsDisplay];
    
    return YES;
}


// 外界赋值时,将评分转换成点位置,进而绘制出评分星星
- (void)setCurrentValue:(float)currentValue {
    _currentValue = currentValue;
    self.touchX = currentValue / 5.0 * self.frame.size.width;
    [self setNeedsDisplay];
}
//绘图
- (void)drawRect:(CGRect)rect{
    
    
    _starWidth = (self.bounds.size.width - starSpace * 5-10) / 5;
    _starAndSpace = starSpace + _starWidth;
    UIImage *image = [UIImage imageNamed:@"evaStar.png"];
    
    for (int i = 0; i < 5; i++) {
        for (int i = 0; i < 5; i ++) {
            CGRect rect = CGRectMake(i * _starAndSpace, 5, _starWidth, self.bounds.size.height-5);
            [image drawInRect:rect];
        }
    }
    //未评分区间颜色
    //    [[UIColor lightGrayColor] setFill];
    //     UIRectFillUsingBlendMode(rect,  kCGBlendModeSourceIn);
    
    
    //评分区间颜色
    CGRect newRect = CGRectMake(0, 0, self.touchX, rect.size.height);
    [[UIColor colorWithHex:0xf30867] set];
    UIRectFillUsingBlendMode(newRect, kCGBlendModeSourceIn);
    CGFloat cu = self.currentValue;
    self.returnB(cu);
}
@end
