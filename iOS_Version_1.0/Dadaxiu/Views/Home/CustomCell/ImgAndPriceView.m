//
//  ImgAndPriceView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ImgAndPriceView.h"

#define price_H 15*CGRectGetWidth(self.frame)/113
#define price_W 40*price_H/15

#define price_Font 10*kScreen_Width/375

@interface ImgAndPriceView ()

//@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIImageView *priceImgV;


@end

@implementation ImgAndPriceView

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
    _imageV = [UIImageView new];
    _imageV.image = [UIImage imageWithColor:DefaultImgBgColor];
    [_imageV handleCornerRadiusWithRadius:2];
    [self addSubview:_imageV];
    
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    _priceImgV = [UIImageView new];
    _priceImgV.image = [UIImage imageNamed:@"home_price_bg"];
    [_imageV addSubview:_priceImgV];
    [_priceImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(0));
        make.right.equalTo(@(0));
        make.width.equalTo(@(price_W));
        make.height.equalTo(@(price_H));
    }];
    
    _priceLb = [UILabel new];
    _priceLb.text = @"";
    _priceLb.textAlignment = NSTextAlignmentRight;
    _priceLb.font = [UIFont systemFontOfSize:price_Font];
    _priceLb.textColor = [UIColor whiteColor];
    [_priceImgV addSubview:_priceLb];
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
}

@end
