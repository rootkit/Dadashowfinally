//
//  UIView+EmptyView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/22.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "UIView+EmptyView.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic,copy) void(^reloadAction)();

@end

@implementation UIView (EmptyView)

- (void)setReloadAction:(void (^)())reloadAction{
    objc_setAssociatedObject(self, @selector(reloadAction), reloadAction, OBJC_ASSOCIATION_COPY);
}

- (void (^)())reloadAction{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - DDXEmptyLoadingView

- (void)setLoadingView:(DDXEmptyLoadingView *)loadingView
{
    [self willChangeValueForKey:NSStringFromSelector(@selector(loadingView))];
    objc_setAssociatedObject(self, @selector(loadingView), loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:NSStringFromSelector(@selector(loadingView))];
}

- (DDXEmptyLoadingView *)loadingView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)beginLoading
{
    if (self.loadingView.superview) { [self.loadingView removeFromSuperview]; }
    if (self.emptyLbView.superview) { [self.emptyLbView removeFromSuperview]; }
    if (self.emptyBtnView.superview) { [self.emptyBtnView removeFromSuperview]; }
    if (self.emptyOrderView.superview) { [self.emptyOrderView removeFromSuperview]; }
    
    if (!self.loadingView) {
        self.loadingView = [[DDXEmptyLoadingView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.loadingView];
    [self bringSubviewToFront:self.loadingView];
    
    [self.loadingView startAnimation];
}

- (void)endLoading
{
    if (self.loadingView) {
        [self.loadingView stopAnimation];
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }
}

#pragma mark - DDXEmptyLbView

- (void)setEmptyLbView:(DDXEmptyLbView *)emptyLbView
{
    [self willChangeValueForKey:NSStringFromSelector(@selector(emptyLbView))];
    objc_setAssociatedObject(self, @selector(emptyLbView), emptyLbView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:NSStringFromSelector(@selector(emptyLbView))];
}

- (DDXEmptyLbView *)emptyLbView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)showEmptyPageViewWithImage:(UIImage* )image
                               tip:(NSString* )tip
{
    if (self.loadingView.superview) { [self.loadingView removeFromSuperview]; }
    if (self.emptyLbView.superview) { [self.emptyLbView removeFromSuperview]; }
    if (self.emptyBtnView.superview) { [self.emptyBtnView removeFromSuperview]; }
    if (self.emptyOrderView.superview) { [self.emptyOrderView removeFromSuperview]; }
    
    if (!self.emptyLbView) {
        self.emptyLbView = [[DDXEmptyLbView alloc] initWithImage:image tip:tip];
        self.emptyLbView.frame = self.bounds;
    }
    [self addSubview:self.emptyLbView];
    [self bringSubviewToFront:self.emptyLbView];
}

#pragma mark - DDXEmptyOrderView

- (void)setEmptyOrderView:(DDXEmptyOrderView *)emptyOrderView
{
    [self willChangeValueForKey:NSStringFromSelector(@selector(emptyOrderView))];
    objc_setAssociatedObject(self, @selector(emptyOrderView), emptyOrderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:NSStringFromSelector(@selector(emptyOrderView))];
}

- (DDXEmptyOrderView *)emptyOrderView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)showEmptyOrderPageViewWithImage:(UIImage *)image tip:(NSString *)tip
{
    if (self.loadingView.superview) { [self.loadingView removeFromSuperview]; }
    if (self.emptyLbView.superview) { [self.emptyLbView removeFromSuperview]; }
    if (self.emptyBtnView.superview) { [self.emptyBtnView removeFromSuperview]; }
    if (self.emptyOrderView.superview) { [self.emptyOrderView removeFromSuperview]; }
    
    if (!self.emptyOrderView) {
        self.emptyOrderView = [[DDXEmptyOrderView alloc] initWithOrderPlaceholderImage:image tip:tip];
        self.emptyOrderView.frame = self.bounds;
    }
    [self addSubview:self.emptyOrderView];
    [self bringSubviewToFront:self.emptyOrderView];
}

#pragma mark - DDXEmptyBtnView

- (void)setEmptyBtnView:(DDXEmptyBtnView *)emptyBtnView
{
    [self willChangeValueForKey:NSStringFromSelector(@selector(emptyBtnView))];
    objc_setAssociatedObject(self, @selector(emptyBtnView), emptyBtnView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:NSStringFromSelector(@selector(emptyBtnView))];
}

- (DDXEmptyBtnView *)emptyBtnView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)showEmptyPageViewWithImage:(UIImage* )image
                               tip:(NSString* )tip
                       buttonTitle:(NSString *)title
{
    if (self.loadingView.superview) { [self.loadingView removeFromSuperview]; }
    if (self.emptyLbView.superview) { [self.emptyLbView removeFromSuperview]; }
    if (self.emptyBtnView.superview) { [self.emptyBtnView removeFromSuperview]; }
    if (self.emptyOrderView.superview) { [self.emptyOrderView removeFromSuperview]; }
    
    if (!self.emptyBtnView) {
        self.emptyBtnView = [[DDXEmptyBtnView alloc] initWithImage:image tip:tip buttonTitle:title];
        self.emptyBtnView.frame = self.bounds;
        if (self.reloadAction) {
            self.emptyBtnView.didClickActionBlock = self.reloadAction;
        }
    }
    [self addSubview:self.emptyBtnView];
    [self bringSubviewToFront:self.emptyBtnView];
}

#pragma mark - hidden

- (void)hideAllGeneralPage
{
    if (self.loadingView.superview) { [self.loadingView removeFromSuperview]; }
    if (self.emptyLbView.superview) { [self.emptyLbView removeFromSuperview]; }
    if (self.emptyBtnView.superview) { [self.emptyBtnView removeFromSuperview]; }
    if (self.emptyOrderView.superview) { [self.emptyOrderView removeFromSuperview]; }
    
    self.loadingView = nil;
    self.emptyLbView = nil;
    self.emptyBtnView = nil;
    self.emptyOrderView = nil;
}

#pragma mark - action

- (void)configReloadAction:(void(^)())block
{
    self.reloadAction = block;
    if (self.emptyBtnView) {
        self.emptyBtnView.didClickActionBlock = self.reloadAction;
    }
}

@end

/**************** 无按钮 *****************/
#pragma mark --- DDXEmptyLbView
@implementation DDXEmptyLbView

- (instancetype)initWithImage:(UIImage* )image
                          tip:(NSString* )tip
{
    self = [super init];
    if (self) {
        UIImageView* nodataImageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:nodataImageView];
        
        UILabel* nodataTipLabel = [[UILabel alloc]init];
        nodataTipLabel.numberOfLines = 1;
        nodataTipLabel.font = [UIFont systemFontOfSize:12];
        nodataTipLabel.textAlignment = NSTextAlignmentCenter;
        nodataTipLabel.textColor = [UIColor colorWithHex:0x333333];
        nodataTipLabel.text = tip;
        [self addSubview:nodataTipLabel];
        
        [nodataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(165*rating));
            make.height.equalTo(@(195*rating));
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(140*rating);
        }];
        
        [nodataTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@(14*rating));
            make.top.equalTo(nodataImageView.mas_bottom).offset(18*rating);
        }];
    }
    return self;
}

@end

/**************** 无按钮 *****************/
#pragma mark --- DDXEmptyOrderView
@implementation DDXEmptyOrderView

- (instancetype)initWithOrderPlaceholderImage:(UIImage* )image
                                          tip:(NSString* )tip
{
    self = [super init];
    if (self) {
        UIImageView* nodataImageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:nodataImageView];
        
        UILabel* nodataTipLabel = [[UILabel alloc]init];
        nodataTipLabel.numberOfLines = 1;
        nodataTipLabel.font = [UIFont systemFontOfSize:12];
        nodataTipLabel.textAlignment = NSTextAlignmentCenter;
        nodataTipLabel.textColor = [UIColor colorWithHex:0x333333];
        nodataTipLabel.text = tip;
        [self addSubview:nodataTipLabel];
        
        [nodataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(165*rating));
            make.height.equalTo(@(195*rating));
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(20*rating);
        }];
        
        [nodataTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@(14*rating));
            make.top.equalTo(nodataImageView.mas_bottom).offset(18*rating);
        }];
    }
    return self;
}

@end

/**************** 有按钮 *****************/
#pragma mark --- DDXEmptyBtnView
@implementation DDXEmptyBtnView

- (instancetype)initWithImage:(UIImage* )image
                          tip:(NSString* )tip
                  buttonTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        UIImageView* loginImageView = [[UIImageView alloc]initWithImage:image];
        loginImageView = loginImageView;
        [self addSubview:loginImageView];
        
        UILabel* loginTipLabel = [[UILabel alloc]init];
        loginTipLabel.numberOfLines = 1;
        loginTipLabel.font = [UIFont systemFontOfSize:12*rating];
        loginTipLabel.textAlignment = NSTextAlignmentCenter;
        loginTipLabel.textColor = [UIColor colorWithHex:0x333333];
        loginTipLabel.text = tip;
        [self addSubview:loginTipLabel];
        
        UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.layer.masksToBounds = YES;
        loginButton.layer.cornerRadius = 12*rating;
        loginButton.layer.borderColor = ThemeColor.CGColor;
        loginButton.layer.borderWidth = 1.0f;
        [loginButton setTitle:title forState:UIControlStateNormal];
        [loginButton setTitleColor:ThemeColor forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(buttonClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loginButton];
        
        
        [loginImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(165*rating));
            make.height.equalTo(@(195*rating));
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(140*rating);
        }];
        
        [loginTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@(14*rating));
            make.top.equalTo(loginImageView.mas_bottom).offset(18*rating);
        }];
        
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(120*rating));
            make.height.equalTo(@(25*rating));
            make.centerX.equalTo(self);
            make.top.equalTo(loginTipLabel.mas_bottom).offset(23*rating);
        }];
    }
    return self;
}

- (void)buttonClickAction
{
    if (_didClickActionBlock) {
        _didClickActionBlock();
    }
}

@end

/**************** 加载 *****************/
#pragma mark --- DDXEmptyLoadingView

@interface DDXEmptyLoadingView ()

@property (nonatomic,weak) UIActivityIndicatorView *loadingImageView;
@property (nonatomic,assign,readwrite) BOOL isLoading ;

@end

@implementation DDXEmptyLoadingView

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _isLoading = NO;
        
//        UIImageView *loadingImageView = [UIImageView new];
        UIActivityIndicatorView *loadingImageView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:loadingImageView];
        
        UILabel* loadingTipLabel = [[UILabel alloc]init];
        loadingTipLabel.numberOfLines = 1;
        loadingTipLabel.font = [UIFont systemFontOfSize:12*rating];
        loadingTipLabel.textAlignment = NSTextAlignmentCenter;
        loadingTipLabel.textColor = [UIColor grayColor];
        loadingTipLabel.text = @"正在加载...";
        [self addSubview:loadingTipLabel];
        
        [loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(165*rating));
            make.height.equalTo(@(195*rating));
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(140*rating);
        }];
        
        [loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@(14*rating));
            make.top.equalTo(loadingImageView.mas_bottom).offset(18*rating);
        }];
    }
    return self;
}

- (void)startAnimation
{
    [_loadingImageView startAnimating];
    _isLoading = YES;
}

- (void)stopAnimation
{
    [_loadingImageView stopAnimating];
    _isLoading = NO;
}

@end
