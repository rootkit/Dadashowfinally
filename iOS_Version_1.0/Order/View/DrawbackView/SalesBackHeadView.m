//
//  SalesBackHeadView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SalesBackHeadView.h"

@implementation SalesBackHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutCustomHeadView];
    }
    return self;
}

- (void)layoutCustomHeadView
{
    UIImageView *goodsImg = [UIImageView new];
    goodsImg.backgroundColor = DefaultImgBgColor;
    [goodsImg handleCornerRadiusWithRadius:3];
    [self addSubview:goodsImg];
    [goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.centerY.equalTo(self);
        make.width.equalTo(@(70*rating));
        make.height.equalTo(@(70*rating));
    }];
    
    UILabel *goodsNameLb = [UILabel new];
    goodsNameLb.textColor = FirstTextColor;
    goodsNameLb.text = @"乐町2017夏季新款女装绿色短款刺绣宽松短袖T恤女夏韩版纯色上衣";
    goodsNameLb.font = [UIFont systemFontOfSize:12*rating];
    goodsNameLb.numberOfLines = 0;
    goodsNameLb.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:goodsNameLb];
    [goodsNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsImg.mas_right).with.offset(12*rating);
        make.top.equalTo(goodsImg.mas_top);
        make.right.equalTo(@(-12));
    }];
    
    UILabel *detailInfoLb = [UILabel new];
    detailInfoLb.text = @"颜色：橙色； 尺码：M";
    detailInfoLb.font = [UIFont systemFontOfSize:12*rating];
    detailInfoLb.textColor = IconTextColor;
    [self addSubview:detailInfoLb];
    [detailInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodsNameLb.mas_bottom).with.offset(10*rating);
        make.left.equalTo(goodsNameLb.mas_left);
        make.right.equalTo(goodsNameLb.mas_right);
    }];
}


@end
