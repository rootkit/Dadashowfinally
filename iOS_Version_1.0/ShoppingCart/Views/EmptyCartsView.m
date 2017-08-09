//
//  EmptyCartsView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/18.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "EmptyCartsView.h"


#define icon_W 145*kScreen_Width/375
#define icon_H 101*kScreen_Width/375
#define info_H 17*kScreen_Width/375
#define btn_W 100*kScreen_Width/375
#define btn_H 30*kScreen_Width/375

#define top_icon_padding 52*kScreen_Width/375
#define icon_info_padding 11*kScreen_Width/375
#define info_btn_padding 30*kScreen_Width/375

#define info_Font 12*kScreen_Width/375
#define btn_Font 13*kScreen_Width/375

@interface EmptyCartsView ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation EmptyCartsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = BackCellColor;
    
    UIView *backView = [[UIView alloc] initWithFrame:self.frame];
    backView.backgroundColor = BackCellColor;
    [self addSubview:backView];
    
    UIImageView *iconImg = [UIImageView new];
    iconImg.image = [UIImage imageNamed:@"ico_empty_cart"];
    [backView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(top_icon_padding));
        make.width.equalTo(@(icon_W));
        make.height.equalTo(@(icon_H));
        make.centerX.equalTo(self);
    }];
    
    UILabel *label = [UILabel new];
    label.text = @"竟然是空的，我要买买买~";
    label.textColor = [UIColor colorWithHex:0x747474];
    label.font = [UIFont systemFontOfSize:info_Font];
    label.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImg.mas_bottom).with.offset(icon_info_padding);
        make.left.equalTo(@(12));
        make.right.equalTo(@(-12));
        make.height.equalTo(@(info_H));
    }];
    
    UIImageView *buttonImg = [UIImageView new];
    buttonImg.image = [UIImage imageNamed:@"shop_cart_empty_btn"];
    [backView addSubview:buttonImg];
    [buttonImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).with.offset(icon_info_padding);
        make.width.equalTo(@(btn_W));
        make.height.equalTo(@(btn_H));
        make.centerX.equalTo(self);
    }];
    buttonImg.userInteractionEnabled = YES;
    
    _button = [UIButton new];
    [_button setTitle:@"随便逛逛" forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:btn_Font];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonImg addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonImg);
        make.left.equalTo(buttonImg);
        make.right.equalTo(buttonImg);
        make.bottom.equalTo(buttonImg);
    }];
    _button.userInteractionEnabled = YES;
    [_button addTarget:self action:@selector(justLookAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)justLookAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickForJustLookAction)]) {
        [_delegate clickForJustLookAction];
    }
}

@end
