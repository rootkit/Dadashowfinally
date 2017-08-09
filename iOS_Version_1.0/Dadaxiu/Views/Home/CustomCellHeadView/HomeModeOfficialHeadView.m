//
//  HomeModeOfficialHeadView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "HomeModeOfficialHeadView.h"

#define cell_left_padding 12
#define top_icon_padding 15
#define chunkView_H 14* kScreen_Width / 375
#define chunkView_W 5* kScreen_Width / 375
#define chunkView_title_padding 10* kScreen_Width / 375

#define title_font 14* kScreen_Width / 375

@interface HomeModeOfficialHeadView ()

@property (nonatomic, strong) UILabel *titleLb;

@end

@implementation HomeModeOfficialHeadView

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
    
    UIView *chunkView = [UIView new];
    chunkView.backgroundColor = RandomColor;
    [view addSubview:chunkView];
    
    _titleLb = [UILabel new];
    _titleLb.text = @"猜你.喜欢";
    _titleLb.font = [UIFont systemFontOfSize:title_font];
    _titleLb.textColor = [UIColor colorWithHex:0x333333];
    [view addSubview:_titleLb];
    
    [chunkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(top_icon_padding));
        make.width.equalTo(@(chunkView_W));
        make.height.equalTo(@(chunkView_H));
        make.left.equalTo(@(0));
        make.centerY.equalTo(_titleLb);
    }];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chunkView);
        make.left.equalTo(chunkView.mas_right).with.offset(chunkView_title_padding);
        make.right.equalTo(@(0));
    }];
}

- (void)setTitle:(NSString *)title
{
    _titleLb.text = title;
}

@end
