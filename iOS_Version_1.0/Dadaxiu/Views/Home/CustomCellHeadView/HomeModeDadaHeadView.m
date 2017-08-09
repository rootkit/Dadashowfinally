//
//  HomeModeDadaHeadView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "HomeModeDadaHeadView.h"

#define cell_left_padding 12
#define top_icon_padding 15

#define icon_W_H 13*kScreen_Width/375
#define icon_title_padding 6* kScreen_Width / 375

#define title_font 14* kScreen_Width / 375

@interface HomeModeDadaHeadView ()

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *titleLb;

@end

@implementation HomeModeDadaHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(10));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    _iconImg = [UIImageView new];
    _iconImg.image = [UIImage imageNamed:@"icon_dadamovie_Home"];
    [view addSubview:_iconImg];
    
    _titleLb = [UILabel new];
    _titleLb.text = @"搭搭影视";
    _titleLb.font = [UIFont systemFontOfSize:title_font];
    _titleLb.textColor = [UIColor colorWithHex:0x333333];
    [view addSubview:_titleLb];
    
    
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(top_icon_padding));
        make.left.equalTo(@(cell_left_padding));
        make.width.equalTo(@(icon_W_H));
        make.height.equalTo(@(icon_W_H));
        
    }];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImg.mas_right).with.offset(icon_title_padding);
        make.right.equalTo(@(0));
        make.centerY.equalTo(_iconImg);
    }];
}

- (void)setTitle:(NSString *)title
{
    _titleLb.text = title;
}

- (void)setIconName:(NSString *)iconName
{
    _iconImg.image = [UIImage imageNamed:iconName];
}

@end
