//
//  PopBox.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "PopBox.h"

@interface PopBox () <PopBoxViewDelegate>
{
    __weak PopBoxView *_popBoxView;
}

@end

@implementation PopBox
static PopBox *_popBox ;
+ (instancetype)popBoxManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _popBox = [PopBox new];
    });
    return _popBox;

}

- (void)showPoxBox
{
    if (_popBoxView) { _popBoxView = nil;}
    
    PopBoxView *popBoxView = [PopBoxView showPopBoxView];
    _popBoxView = popBoxView;
    popBoxView.frame = [UIScreen mainScreen].bounds;
    popBoxView = popBoxView;
    popBoxView.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:popBoxView];
    
    //背景蒙层的动画：alpha值从0.0变化到0.5
    [popBoxView.bgView setAlpha:0.0];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [popBoxView.bgView setAlpha:0.5];
    } completion:^(BOOL finished) { }];
}

- (void)hiddenPoxBox
{
    if (_popBoxView.superview) {
        [_popBoxView removeFromSuperview];
    }
}

#pragma mark - PopBoxViewDelegate
- (void)startContactAccess:(BOOL)isStart
{
    if (_delegate && [_delegate respondsToSelector:@selector(popBoxStartContactAccess:)]) {
        [_delegate popBoxStartContactAccess:isStart];
    }
}

@end

////

@interface PopBoxView ()

@property (nonatomic, weak) IBOutlet UIButton *cancleButton;
@property (nonatomic, weak) IBOutlet UIButton *startButton;

@end
@implementation PopBoxView

//

+ (instancetype)showPopBoxView
{
    PopBoxView *popBoxView = [[[UINib nibWithNibName:@"PopBox" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    return popBoxView;
}


- (IBAction)cancleAction:(id)sender
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(startContactAccess:)]) {
        [_delegate startContactAccess:NO];
    }
}


- (IBAction)startAction:(id)sender
{
    NSLog(@"启用");
    if (self.superview) {
        [self removeFromSuperview];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(startContactAccess:)]) {
        [_delegate startContactAccess:YES];
    }
}

@end
