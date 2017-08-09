//
//  FlashSaleView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/11.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FlashSaleView.h"

#define top_padding 10
#define left_padding 12
#define bottom_padding 0
#define right_padding left_padding

#define icon_W_H 15*kScreen_Width/375
#define title_font 15*kScreen_Width/375

#define time_W_H 13*kScreen_Width/375
#define time_icon_img_H 5*kScreen_Width/375
#define time_icon_img_W 1

#define time_info_font 8*kScreen_Width/375
#define time_title_font 11*kScreen_Width/375

@interface FlashSaleView ()

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *timeHourLb;
@property (nonatomic, strong) UILabel *timeMinuteLb;
@property (nonatomic, strong) UILabel *timeSecondLb;
@property (nonatomic, strong) UIImageView *minuteImg;
@property (nonatomic, strong) UIImageView *secondImg;



@end

@implementation FlashSaleView

- (instancetype)initWithFrame:(CGRect)frame//home_flashsale_tuijian home_flashsale_temai
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutIMG];
    }
    return self;
}

- (void)layoutIMG
{
    _iconImg = [UIImageView new];
    _iconImg.image = [UIImage imageNamed:@"icon_didamiao_Home"];
    [self addSubview:_iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(top_padding));
        make.left.equalTo(@(left_padding));
        make.width.equalTo(@(icon_W_H));
        make.height.equalTo(@(icon_W_H));
    }];
    
    _titleLb = [UILabel new];
    _titleLb.text = @"滴搭秒";
    _titleLb.font = [UIFont systemFontOfSize:title_font];
    _titleLb.textColor = [UIColor colorWithHex:0x333333];
    [self addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImg.mas_right).with.offset(4);
        make.centerY.equalTo(_iconImg);
    }];
    
    //倒计时
    _timeSecondLb = [UILabel new];
    _timeSecondLb.text = @"21";
    _timeSecondLb.textAlignment = NSTextAlignmentCenter;
    _timeSecondLb.font = [UIFont systemFontOfSize:time_info_font];
    _timeSecondLb.textColor = [UIColor whiteColor];
    _timeSecondLb.backgroundColor = [UIColor colorWithHex:0x303030];
    [_timeSecondLb handleCornerRadiusWithRadius:2];
    [self addSubview:_timeSecondLb];
    [_timeSecondLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-right_padding));
        make.width.equalTo(@(time_W_H));
        make.height.equalTo(@(time_W_H));
        make.centerY.equalTo(_iconImg);
    }];
    
    _secondImg = [UIImageView new];
    _secondImg.image = [UIImage imageNamed:@"home_flashsale_TimeColon"];
    [self addSubview:_secondImg];
    [_secondImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_timeSecondLb.mas_left).with.offset(-2);
        make.width.equalTo(@(time_icon_img_W));
        make.height.equalTo(@(time_icon_img_H));
        make.centerY.equalTo(_timeSecondLb);
    }];
    
    _timeMinuteLb = [UILabel new];
    _timeMinuteLb.text = @"22";
    _timeMinuteLb.textAlignment = NSTextAlignmentCenter;
    _timeMinuteLb.font = [UIFont systemFontOfSize:time_info_font];
    _timeMinuteLb.textColor = [UIColor whiteColor];
    _timeMinuteLb.backgroundColor = [UIColor colorWithHex:0x303030];
    [_timeMinuteLb handleCornerRadiusWithRadius:2];
    [self addSubview:_timeMinuteLb];
    [_timeMinuteLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secondImg.mas_left).with.offset(-2);
        make.width.equalTo(@(time_W_H));
        make.height.equalTo(@(time_W_H));
        make.centerY.equalTo(_iconImg);
    }];
    
    _minuteImg = [UIImageView new];
    _minuteImg.image = [UIImage imageNamed:@"home_flashsale_TimeColon"];
    [self addSubview:_minuteImg];
    [_minuteImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_timeMinuteLb.mas_left).with.offset(-2);
        make.width.equalTo(@(time_icon_img_W));
        make.height.equalTo(@(time_icon_img_H));
        make.centerY.equalTo(_timeSecondLb);
    }];
    
    _timeHourLb = [UILabel new];
    _timeHourLb.text = @"01";
    _timeHourLb.textAlignment = NSTextAlignmentCenter;
    _timeHourLb.font = [UIFont systemFontOfSize:time_info_font];
    _timeHourLb.textColor = [UIColor whiteColor];
    _timeHourLb.backgroundColor = [UIColor colorWithHex:0x303030];
    [_timeHourLb handleCornerRadiusWithRadius:2];
    [self addSubview:_timeHourLb];
    [_timeHourLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_minuteImg.mas_left).with.offset(-2);
        make.width.equalTo(@(time_W_H));
        make.height.equalTo(@(time_W_H));
        make.centerY.equalTo(_iconImg);
    }];
    
    _timeLb = [UILabel new];
    _timeLb.text = @"8点场";
    _timeLb.textAlignment = NSTextAlignmentRight;
    _timeLb.font = [UIFont systemFontOfSize:time_title_font];
    _timeLb.textColor = [UIColor colorWithHex:0x5e5e5e];
    [self addSubview:_timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_timeHourLb.mas_left).with.offset(-10);
        make.width.equalTo(@(50));
//        make.height.equalTo(@(time_W_H));
        make.centerY.equalTo(_iconImg);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImg.mas_bottom).with.offset(5);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    CGFloat viewWidth = (CGRectGetWidth(self.frame)-left_padding-right_padding - 3*4)/4;
    CGFloat viewHeight = 113*viewWidth/85;
    CGFloat viewPadding = 4;
    
    for (int i = 0; i < 4; i++) {
        SaleSubView *subView = [[SaleSubView alloc] initWithFrame:CGRectMake(left_padding+(viewWidth+viewPadding)*i, 0, viewWidth, viewHeight)];
        [bottomView addSubview:subView];
        subView.tag = i+1;
        [subView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)]];
    }
}

#pragma mark - tap action
- (void)clickAction:(UITapGestureRecognizer *)tap
{

    if (_delegate && [_delegate respondsToSelector:@selector(clickSaleGoodsWithTags:)]) {
        [_delegate clickSaleGoodsWithTags:tap.view.tag];
    }
}

@end

///////

#define IMG_H 72*kScreen_Width/375
#define IMG_W 61*kScreen_Width/375

#define tagImg_H 15*kScreen_Width/375
#define tagImg_W 35*kScreen_Width/375

#define img_price_padding 8*kScreen_Width/375
#define price_history_padding 4*kScreen_Width/375
#define history_bottom_padding 7*kScreen_Width/375

#define price_Height 14*kScreen_Width/375
#define history_price_Height 8*kScreen_Width/375

#define price_front_font 10*kScreen_Width/375
#define price_after_font 18*kScreen_Width/375
#define history_price_font 10*kScreen_Width/375

@interface SaleSubView ()

@property (nonatomic, strong) UIImageView *goodsIMG;
@property (nonatomic, strong) UIImageView *tagsIMG;

@property (nonatomic, strong)UILabel *priceLb;
@property (nonatomic, strong)UILabel *historyPriceLb;

@end

@implementation SaleSubView

- (instancetype)initWithFrame:(CGRect)frame//home_flashsale_tuijian home_flashsale_temai
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutSubview];
    }
    return self;
}

- (void)layoutSubview
{
    _goodsIMG = [UIImageView new];
    _goodsIMG.backgroundColor = DefaultImgBgColor;
    _goodsIMG.clipsToBounds = YES;
    _goodsIMG.contentMode = UIViewContentModeRedraw;
    [_goodsIMG handleCornerRadiusWithRadius:2];
//    _goodsIMG.backgroundColor = ThemeColor;
    [self addSubview:_goodsIMG];
    [_goodsIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.width.equalTo(@(IMG_W));
        make.height.equalTo(@(IMG_H));
        make.centerX.equalTo(self);
    }];
    
    _tagsIMG = [UIImageView new];
    _tagsIMG.image = [UIImage imageNamed:@"home_flashsale_tuijian"];;
    [self addSubview:_tagsIMG];
    [_tagsIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(tagImg_W));
        make.height.equalTo(@(tagImg_H));
        make.centerX.equalTo(self);
        make.centerY.equalTo(_goodsIMG.mas_bottom).with.offset(-3);
    }];
    
    _priceLb = [UILabel new];
    _priceLb.attributedText = [Util changeStringType:@"¥" withPrice:@"69.9" withTypeFont:[UIFont systemFontOfSize:price_front_font] withPriceFont:[UIFont systemFontOfSize:price_after_font] withReturn:NO];
    _priceLb.textColor = ThemeColor;
    _priceLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_priceLb];
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsIMG.mas_bottom).with.offset(img_price_padding);
        make.centerX.equalTo(self);
        make.height.equalTo(@(price_Height));
    }];
    
    _historyPriceLb = [UILabel new];
    _historyPriceLb.text = @"¥149";
    _historyPriceLb.font = [UIFont systemFontOfSize:history_price_font];
    _historyPriceLb.textColor = [UIColor colorWithHex:0x747474];
    _historyPriceLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_historyPriceLb];
    [_historyPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLb.mas_bottom).with.offset(price_history_padding);
//        make.bottom.equalTo(self).with.offset(-history_bottom_padding);
        make.centerX.equalTo(self);
        make.height.equalTo(@(history_price_Height));
    }];
    
    UILabel* line=[UILabel new];
    line.backgroundColor = IconTextColor;
    [_historyPriceLb addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_historyPriceLb);
        make.left.equalTo(_historyPriceLb.mas_left);
        make.height.equalTo(@1);
        make.right.equalTo(_historyPriceLb.mas_right);
    }];
}


@end
