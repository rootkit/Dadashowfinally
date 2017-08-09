//
//  FifthHeaderView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/11.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FifthHeaderView.h"

#define topIMG_left_top_padding 15*kScreen_Width/375
#define bottomBtn_left_padding 10*kScreen_Width/375
#define bottomBtn_bottom_padding 13*kScreen_Width/375

#define bottomBtn_H_W 54*kScreen_Width/375

#define left_IMG_H 36*kScreen_Width/375
#define left_IMG_W 56*kScreen_Width/375

#define right_IMG_H 33*kScreen_Width/375
#define right_IMG_W 87*kScreen_Width/375

#define state_font 10*kScreen_Width/375
#define price_font 18*kScreen_Width/375

#define IMG_W 170* kScreen_Width / 375
#define IMG_H 236* kScreen_Width / 375

#define img_padding 11* kScreen_Width / 375

@interface FifthHeaderView ()

@property (nonatomic, strong) UIImageView *leftIMG;
@property (nonatomic, strong) UIImageView *lefttopImg;
@property (nonatomic, strong) UIImageView *leftbottomImg;
@property (nonatomic, strong) UILabel *leftstateLb;

@property (nonatomic, strong) UIImageView *rightIMG;
@property (nonatomic, strong) UIImageView *righttopImg;
@property (nonatomic, strong) UIImageView *rightbottomImg;
@property (nonatomic, strong) UILabel *rightstateLb;

@end

@implementation FifthHeaderView
{
    BOOL _touchLeftIMG;
    BOOL _touchRightIMG;
}

- (instancetype)initWithFrame:(CGRect)frame//home_fifth_buttonBg
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutIMG];
    }
    return self;
}

- (void)layoutIMG////  title_brand_Home title_youhui_Home
{
    _leftIMG = [UIImageView new];
    [_leftIMG handleCornerRadiusWithRadius:2];
    _leftIMG.image = [UIImage imageNamed:@"img_09"];
    [self addSubview:_leftIMG];
    [_leftIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(12));
        make.width.equalTo(@(IMG_W));
        make.height.equalTo(@(IMG_H));
    }];
    
    _lefttopImg = [UIImageView new];
    _lefttopImg.image = [UIImage imageNamed:@"title_brand_Home"];
    [_leftIMG addSubview:_lefttopImg];
    [_lefttopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(topIMG_left_top_padding));
        make.left.equalTo(@(topIMG_left_top_padding));
        make.width.equalTo(@(left_IMG_W));
        make.height.equalTo(@(left_IMG_H));
    }];
    
    _leftbottomImg = [UIImageView new];
    _leftbottomImg.image = [UIImage imageNamed:@"home_fifth_buttonBg"];
    _leftbottomImg.hidden = YES;
    [_leftIMG addSubview:_leftbottomImg];
    [_leftbottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(bottomBtn_left_padding));
        make.bottom.equalTo(@(-bottomBtn_bottom_padding));
        make.width.equalTo(@(bottomBtn_H_W));
        make.height.equalTo(@(bottomBtn_H_W));
    }];
    
    _leftstateLb = [UILabel new];
    _leftstateLb.attributedText = [Util changeStringType:@"低至"
                                           withPrice:@"999"
                                        withTypeFont:[UIFont systemFontOfSize:state_font]
                                       withPriceFont:[UIFont systemFontOfSize:price_font]
                                              withReturn:YES];
    _leftstateLb.numberOfLines = 2;
    _leftstateLb.textColor = [UIColor whiteColor];
    _leftstateLb.textAlignment = NSTextAlignmentCenter;
    [_leftbottomImg addSubview:_leftstateLb];
    [_leftstateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_leftbottomImg);
        make.centerY.equalTo(_leftbottomImg);
    }];
    
    ////
    _rightIMG = [UIImageView new];
    [_rightIMG handleCornerRadiusWithRadius:2];
    _rightIMG.image = [UIImage imageNamed:@"img_10"];
    [self addSubview:_rightIMG];
    [_rightIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.right.equalTo(@(-12));
        make.width.equalTo(@(IMG_W));
        make.height.equalTo(@(IMG_H));
    }];
    
    _righttopImg = [UIImageView new];
    _righttopImg.image = [UIImage imageNamed:@"title_youhui_Home"];
    [_rightIMG addSubview:_righttopImg];
    [_righttopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(topIMG_left_top_padding));
        make.left.equalTo(@(topIMG_left_top_padding));
        make.width.equalTo(@(right_IMG_W));
        make.height.equalTo(@(right_IMG_H));
    }];
    
    _rightbottomImg = [UIImageView new];
    _rightbottomImg.image = [UIImage imageNamed:@"home_fifth_buttonBg"];
    _rightbottomImg.hidden = YES;
    [_rightIMG addSubview:_rightbottomImg];
    [_rightbottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(bottomBtn_left_padding));
        make.bottom.equalTo(@(-bottomBtn_bottom_padding));
        make.width.equalTo(@(bottomBtn_H_W));
        make.height.equalTo(@(bottomBtn_H_W));
    }];
    
    _rightstateLb = [UILabel new];
    _rightstateLb.attributedText = [Util changeStringType:@"包邮"
                                               withPrice:@"¥9.9"
                                            withTypeFont:[UIFont systemFontOfSize:state_font]
                                           withPriceFont:[UIFont systemFontOfSize:price_font] withReturn:YES];
    _rightstateLb.numberOfLines = 2;
    _rightstateLb.textColor = [UIColor whiteColor];
    _rightstateLb.textAlignment = NSTextAlignmentCenter;
    [_rightbottomImg addSubview:_rightstateLb];
    [_rightstateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_rightbottomImg);
        make.centerY.equalTo(_rightbottomImg);
    }];
}

#pragma mark --- touch handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _touchLeftIMG = NO;
    _touchRightIMG = NO;
    
    UITouch* t = [touches anyObject];
    CGPoint p1 = [t locationInView:self.leftIMG];
    CGPoint p2 = [t locationInView:self.rightIMG];
    if (CGRectContainsPoint(self.leftIMG.bounds, p1)) {
        _touchLeftIMG = YES;
    } else if (CGRectContainsPoint(self.rightIMG.bounds, p2)) {
        _touchRightIMG = YES;
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchLeftIMG) {
        if (_delegate && [_delegate respondsToSelector:@selector(clickPerferGoodsWithTags:)]) {
            [_delegate clickPerferGoodsWithTags:0];
        }
    } else if (_touchRightIMG) {
        if (_delegate && [_delegate respondsToSelector:@selector(clickPerferGoodsWithTags:)]) {
            [_delegate clickPerferGoodsWithTags:1];
        }
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_touchLeftIMG || !_touchRightIMG) {
        [super touchesCancelled:touches withEvent:event];
    }
}


@end



