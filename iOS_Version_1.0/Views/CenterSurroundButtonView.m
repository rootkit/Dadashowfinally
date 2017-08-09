//
//  CenterSurroundButtonView.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/16.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "CenterSurroundButtonView.h"

#import "UIColor+CustomColor.h"

#define SUB_CIRCLE_RADIUS 28
#define CENTER_X self.center.x
#define CENTER_Y self.bounds.size.height - 50
#define CIRCLE_NUM 4
#define CIRCLE_PADDING 90 //中心圆和周围圆的圆心距

//NSObject

@interface CenterSurroundButtonManager ()
{
    __weak CenterSurroundButtonView *_centerSurroundBtnView;
}
@end

@implementation CenterSurroundButtonManager

static CenterSurroundButtonManager *_centerSurroundBtnManager ;
+ (instancetype)centerSurroundBtnManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _centerSurroundBtnManager = [CenterSurroundButtonManager new];
    });
    return _centerSurroundBtnManager;
}

- (void)showCenterSurroundButtonViewWithType
{
    if (_centerSurroundBtnView) { _centerSurroundBtnView = nil;}
    
    CenterSurroundButtonView *centerSurroundBtnView = [CenterSurroundButtonView showCenterSurroundButtonViewWithTypeTag];
    _centerSurroundBtnView = centerSurroundBtnView;
    centerSurroundBtnView.frame = [UIScreen mainScreen].bounds;
    centerSurroundBtnView = centerSurroundBtnView;
//    centerSurroundBtnView.delegate = self;
    
    [[UIApplication sharedApplication].keyWindow addSubview:centerSurroundBtnView];
    
//    //背景蒙层的动画：alpha值从0.0变化到0.5
//    [centerSurroundBtnView.bgView setAlpha:0.0];
//    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
//        [centerSurroundBtnView.bgView setAlpha:0.5];
//    } completion:^(BOOL finished) { }];
}

- (void)hiddencenterSurroundBtnBoard
{
    if (_centerSurroundBtnView.superview) {
        [_centerSurroundBtnView removeFromSuperview];
    }
}

@end

//uiview
@interface CenterSurroundButtonView ()

@property (nonatomic, weak) UIButton *fitRmBtn;
@property (nonatomic, weak) UIButton *diyBtn;
@property (nonatomic, weak) UIButton *wardBtn;
@property (nonatomic, weak) UIButton *petBtn;

@property (nonatomic, assign) CGPoint centerButtonCenter;//中间按钮中心点
@property (nonatomic, assign) CGFloat angle;//圆心夹角

@end

@implementation CenterSurroundButtonView{
    BOOL _touchTrack;
}


+ (instancetype)showCenterSurroundButtonViewWithTypeTag
{
    CenterSurroundButtonView *centerSurroundBtnView = [CenterSurroundButtonView new];
    centerSurroundBtnView.backgroundColor = [UIColor colorWithWhite:0xffffff alpha:0.1];
    //
    return centerSurroundBtnView;
}

- (void)drawRect:(CGRect)rect {
    
    UIView *bgView = [UIView new];
    self.bgView = bgView;
    bgView.frame = self.bounds;
    [self addSubview:bgView];
    
    self.centerButtonCenter = CGPointMake(CENTER_X, CENTER_Y);
    self.angle = 2*M_PI/CIRCLE_NUM/4;
    
    NSArray *titleArray = @[@"tab-sub-fittingRoom",
                            @"tab-sub-DIY",
                            @"tab-sub-wardrobe",
                            @"tab-sub-pet"
                            ];
    
    for (int i = 0; i < CIRCLE_NUM; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(0, 0, 2*SUB_CIRCLE_RADIUS, 2*SUB_CIRCLE_RADIUS);
        btn.center = self.centerButtonCenter;
        btn.tag = 100+i;
        btn.alpha = 0;
        btn.layer.cornerRadius = SUB_CIRCLE_RADIUS;
        
        if (i == 0) {
            self.fitRmBtn = btn;
        } else if (i == 1) {
            self.diyBtn = btn;
        } else if (i == 2) {
            self.wardBtn = btn;
        } else if (i == 3) {
            self.petBtn = btn;
        }
        
        
        [btn setBackgroundImage:[UIImage imageNamed:titleArray[i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:titleArray[i]]forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(subButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            btn.selected = YES;
        }
        [self addSubview:btn];
    }
    
    [UIView animateWithDuration:0.11 animations:^{
        for (int i = 0; i < CIRCLE_NUM; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:i+100];
            CGFloat x = self.centerButtonCenter.x - CIRCLE_PADDING * cosf(self.angle * (2*i+1));
            CGFloat y = self.centerButtonCenter.y - CIRCLE_PADDING * sinf(self.angle * (2*i+1));
            
            btn.center = CGPointMake(x ,y);
            btn.alpha = 1;
        }
    }];
}

#pragma mark - 扇形按钮点击事件
// 旋转出现
- (void)subButtonClickAction:(UIButton *)button
{
    //按钮点击实现
    NSLog(@"sub BUTTON %ld", (long)button.tag);
    
    [UIView animateWithDuration:1 animations:^{
        for (int i=0; i<7; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:i+100];
            btn.center = self.centerButtonCenter;
            btn.alpha = 0;
        }
    }];
    button.selected = !button.selected;
    
    if (self.superview) {
        [self removeFromSuperview];
    }
}

#pragma mark --- touch handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _touchTrack = NO;
    UITouch* t = [touches anyObject];
    CGPoint p1 = [t locationInView:self.fitRmBtn];
    CGPoint p2 = [t locationInView:self.bgView];
    if (!CGRectContainsPoint(self.fitRmBtn.bounds, p1)) {
        _touchTrack = YES;
    } else if (!CGRectContainsPoint(self.bgView.bounds, p2)) {
        _touchTrack = YES;
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchTrack) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }else{
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchTrack) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }else{
        [super touchesCancelled:touches withEvent:event];
    }
}

@end
