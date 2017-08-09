//
//  AddNewFriendBox.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/18.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "AddNewFriendBox.h"

#define boxView_ContentView_Height 190
#define boxView_ContentView_origin_Y (kScreen_Height-boxView_ContentView_Height)/2

@interface AddNewFriendManager () <AddNewFriendBoxDelegate>
{
    __weak AddNewFriendBox *_boxView;
    CGFloat minY;
    BOOL isShowKeyboard;
}

@end

@implementation AddNewFriendManager

static AddNewFriendManager *_boxManager ;
+ (instancetype)popBoxManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _boxManager = [AddNewFriendManager new];
    });
    return _boxManager;
    
}

- (void)showPoxBoxWithNewFriendName:(NSString *)name
{
    if (_boxView) { _boxView = nil;}
    
    AddNewFriendBox *popBoxView = [AddNewFriendBox showBoxView];
    [popBoxView showNewFriendName:name];
    _boxView = popBoxView;
    popBoxView.frame = [UIScreen mainScreen].bounds;
    popBoxView = popBoxView;
    popBoxView.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:popBoxView];
    
    //背景蒙层的动画：alpha值从0.0变化到0.5
    [popBoxView.bgView setAlpha:0.0];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [popBoxView.bgView setAlpha:0.5];
    } completion:^(BOOL finished) { }];
    
    //软键盘
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAction:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAction:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [popBoxView.infoTf addTarget:self action:@selector(returnOnKeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void)hiddenPoxBox
{
    if (_boxView.superview) {
        [_boxView removeFromSuperview];
    }
}

- (void)returnOnKeyboard
{
    [_boxView.infoTf resignFirstResponder];
}

- (void)keyboardAction:(NSNotification *)notification
{
    CGSize size = _boxView.contentView.frame.size;
    CGPoint point = _boxView.contentView.frame.origin;
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval timeInt;
    [animationDuration getValue:&timeInt];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGFloat keyBoradHeight = keyboardRect.size.height;
    if (keyBoradHeight <= 0) {
        return;
    }
    
    minY = boxView_ContentView_origin_Y - keyBoradHeight/2;
    
    if (notification.name == UIKeyboardWillShowNotification) {
//        if (isShowKeyboard == NO) {
            [UIView animateWithDuration:timeInt
                                  delay:0.f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                _boxView.contentView.frame = CGRectMake(point.x, minY, size.width, size.height);
                                 
                             } completion:^(BOOL finished) {
                                 isShowKeyboard = YES;
                             }];
//        }
        
        
    } else if (notification.name == UIKeyboardWillHideNotification) {
        [UIView animateWithDuration:-timeInt
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _boxView.contentView.frame = CGRectMake(point.x, boxView_ContentView_origin_Y, size.width, size.height);
                         } completion:^(BOOL finished) {
                             isShowKeyboard = NO;
                         }];
    }
}

#pragma mark - AddNewFriendBoxDelegate
- (void)clickByInfo:(NSString *)infoString
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickByInfo:)]) {
        [_delegate clickByInfo:infoString];
    }
}


@end

/*   AddNewFriendBox   */

@interface AddNewFriendBox ()

@property (weak, nonatomic) IBOutlet UILabel *firendNameLb;


@end

@implementation AddNewFriendBox
{
    BOOL _touchTrack;
}

+ (instancetype)showBoxView
{
    AddNewFriendBox *popBoxView = [[[UINib nibWithNibName:@"AddNewFriendBox" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    return popBoxView;
}

- (void)showNewFriendName:(NSString *)name
{
    _firendNameLb.text = [NSString stringWithFormat:@"正在添加 %@ 为好友", name];
}

- (IBAction)cancleAction:(UIButton *)sender {
    [self hiddenBoard];
}

- (IBAction)sendAction:(UIButton *)sender {
    [self hiddenBoard];
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickByInfo:)]) {
        [_delegate clickByInfo:_infoTf.text];
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
    if ([_infoTf isFirstResponder]) {
        [_infoTf resignFirstResponder];
    } else {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }
    
}

@end
