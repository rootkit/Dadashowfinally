//
//  GoodsListChoosePriceBoard.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GoodsListChoosePriceBoard.h"


#define BOARD_HEIGHT priceView.bounds.size.height
#define BOARD_WIDTH priceView.bounds.size.width
@interface GoodsListChoosePriceBoard () <GoodsListChoosePriceViewDelegate>
{
    __weak GoodsListChoosePriceView *_priceView;
}
@end

@implementation GoodsListChoosePriceBoard

static GoodsListChoosePriceBoard *_priceBoard;
+ (instancetype)goodsListChoosePriceBoardManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _priceBoard = [GoodsListChoosePriceBoard new];
    });
    return _priceBoard;
}

- (void)showBoard
{
    if (_priceView) {
        _priceView = nil;
    }
    
    GoodsListChoosePriceView *priceView = [GoodsListChoosePriceView showGoodsListChoosePriceView];
    _priceView = priceView;
    priceView.frame = [UIScreen mainScreen].bounds;
    priceView = priceView;
    priceView.delegate = self;
    
    [[UIApplication sharedApplication].keyWindow addSubview:priceView];
    
    //背景蒙层的动画：alpha值从0.0变化到0.5
    [priceView.bgView setAlpha:0.0];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [priceView.bgView setAlpha:0.5];
    } completion:^(BOOL finished) { }];
    
    //分享面板的动画：从底部向上滚动弹出来
    [priceView.contentView setFrame:CGRectMake(0, priceView.priceViewY.constant, BOARD_WIDTH, BOARD_HEIGHT )];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [priceView.contentView setFrame:CGRectMake(0, priceView.priceViewY.constant, BOARD_WIDTH, BOARD_HEIGHT)];
    } completion:^(BOOL finished) {}];
}

- (void)hiddenBoard
{
    if (_priceView.superview) {
        [_priceView removeFromSuperview];
    }
}

#pragma mark - GoodsListChoosePriceViewDelegate
- (void)clickeWithPrice:(NSString *)minPrice max:(NSString *)maxPrice
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickeWithPrice:max:)]) {
        [_delegate clickeWithPrice:minPrice max:maxPrice];
    }
}

@end

////////

@interface GoodsListChoosePriceView ()

@property (weak, nonatomic) IBOutlet UITextField *minPriceLb;
@property (weak, nonatomic) IBOutlet UITextField *maxPriceLb;

@end

@implementation GoodsListChoosePriceView
{
    BOOL _touchTrack;
}

+ (instancetype)showGoodsListChoosePriceView
{
    GoodsListChoosePriceView *priceView = [[[UINib nibWithNibName:@"GoodsListChoosePriceBoard" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    
    return priceView;
}

- (IBAction)clickAction:(UIButton *)sender {
    if (_minPriceLb.text.length > 0 && _maxPriceLb.text.length > 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(clickeWithPrice:max:)]) {
            [_delegate clickeWithPrice:_minPriceLb.text max:_maxPriceLb.text];
        }
        
        if (self.superview) {
            [self removeFromSuperview];
        }
    }
    
}

#pragma mark --- touch handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _touchTrack = NO;
    UITouch* t = [touches anyObject];
    CGPoint p1 = [t locationInView:_contentView];
    if (!CGRectContainsPoint(_contentView.bounds, p1)) {
        _touchTrack = YES;
    }else{
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
