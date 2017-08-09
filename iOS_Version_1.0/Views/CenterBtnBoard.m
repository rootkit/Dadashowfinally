//
//  CenterBtnBoard.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/16.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "CenterBtnBoard.h"
#import "DIYWebController.h"
#import "JSClotherRoomSencondViewController.h"

#define BOARD_HEIGHT centerBoard.bounds.size.height
#define BOARD_WIDTH centerBoard.bounds.size.width

#define BOARD_ANIMATION_Y kScreen_Height-49-BOARD_HEIGHT

@interface CenterBtnManager ()
{
    __weak CenterBtnBoard *_centerBoard;
}

@end

@implementation CenterBtnManager

static CenterBtnManager *_centerManager;
+ (instancetype)centerBtnManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _centerManager = [CenterBtnManager new];
    });
    return _centerManager;
}


- (void)showCenterBtn
{
    if (_centerBoard) {
        _centerBoard = nil;
    }
    
    CenterBtnBoard *centerBoard = [CenterBtnBoard showCenterBoard];
    [self layerForCycleView:centerBoard.contentView];
    _centerBoard = centerBoard;
    centerBoard.frame = [UIScreen mainScreen].bounds;
    
    [[UIApplication sharedApplication].keyWindow addSubview:centerBoard];
    
    //分享面板的动画：从底部向上滚动弹出来
    [centerBoard.btnView setFrame:CGRectMake(0, BOARD_ANIMATION_Y+BOARD_HEIGHT , BOARD_WIDTH, BOARD_HEIGHT )];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [centerBoard.btnView setFrame:CGRectMake(0, BOARD_ANIMATION_Y, BOARD_WIDTH, BOARD_HEIGHT)];
    } completion:^(BOOL finished) {}];
    
    [centerBoard.contentView setFrame:CGRectMake(0, BOARD_ANIMATION_Y+BOARD_HEIGHT , BOARD_WIDTH, BOARD_HEIGHT)];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [centerBoard.contentView setFrame:CGRectMake(0, BOARD_ANIMATION_Y, BOARD_WIDTH, BOARD_HEIGHT)];
    } completion:^(BOOL finished) {}];
}

- (void)hiddenCenterBtnBoard
{
    if (_centerBoard.superview) {
        [_centerBoard removeFromSuperview];
    }
}

/* 按钮背景添加渐变色 */
- (void)layerForCycleView:(UIView *)bottomView
{
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[
                     (__bridge id)[UIColor colorWithHex:0xffffff alpha:0.0].CGColor,
                     (__bridge id)[UIColor colorWithHex:0xffffff alpha:0.5].CGColor,
                     (__bridge id)[UIColor colorWithHex:0xffffff alpha:0.0].CGColor,
                     ];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1);
    layer.frame = bottomView.bounds;
    layer.locations = @[@1.0, @0.3, @01.0];
    
    [bottomView.layer addSublayer:layer];
}

@end


/////

@interface CenterBtnBoard ()

@end

@implementation CenterBtnBoard
{
    BOOL _touchTrack;
}

+ (instancetype)showCenterBoard
{
    CenterBtnBoard *board = [[[UINib nibWithNibName:@"CenterBtnBoard" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    
    return board;
}

#pragma mark - action

- (IBAction)ButtonClick:(UIButton *)sender {
    UIViewController* curViewController = [self topViewControllerForViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    
    switch (sender.tag) {
        case 1:
        {
            //试衣间
            NSLog(@"试衣间");
            JSClotherRoomSencondViewController* jsvc=[[JSClotherRoomSencondViewController alloc]init];
            UINavigationController* navi=[[UINavigationController alloc]initWithRootViewController:jsvc];
            [curViewController presentViewController:navi animated:YES completion:nil];

            
            break;
        }
        case 2:
        {
            //DIY
            NSLog(@"DIY");
            [curViewController presentViewController:[[DIYWebController alloc] initWithUrl:DDXAPI_DIY] animated:YES completion:nil];
            break;
        }
        case 3:
        {
            //衣柜
            NSLog(@"衣柜");
            [curViewController presentViewController:[[DIYWebController alloc] initWithUrl:DDXAPI_FITTINGROOM] animated:YES completion:nil];
            break;
        }
        case 4:
        {
            //宠物
            NSLog(@"宠物");
            [curViewController presentViewController:[[DIYWebController alloc] initWithUrl:DDXAPI_PET] animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
    
    [self hiddenBoard];
}

- (UIViewController *)topViewControllerForViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self topViewControllerForViewController:navigationController.visibleViewController];
    }
    
    if (rootViewController.presentedViewController) {
        return [self topViewControllerForViewController:rootViewController.presentedViewController];
    }
    
    return rootViewController;
}

#pragma mark --- touch handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _touchTrack = NO;
    UITouch* t = [touches anyObject];
    CGPoint p1 = [t locationInView:_btnView];
    if (!CGRectContainsPoint(_btnView.bounds, p1)) {
        _touchTrack = YES;
    }else{
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchTrack) {
        [self hiddenBoard];
    }else{
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchTrack) {
        [self hiddenBoard];
    }else{
        [super touchesCancelled:touches withEvent:event];
    }
}

- (void)hiddenBoard
{
    if (self.superview) {
        [self removeFromSuperview];
    }
}

@end
