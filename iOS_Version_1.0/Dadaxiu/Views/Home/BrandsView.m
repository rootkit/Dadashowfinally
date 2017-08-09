//
//  BrandsView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "BrandsView.h"

@interface BrandsView ()


@property (nonatomic, strong) UILabel *brandTitleLb;
@property (nonatomic, strong) UILabel *brandInfoLb;


@property (nonatomic, strong) UILabel *hotTitleLb;
@property (nonatomic, strong) UILabel *hotInfoLb;


@property (nonatomic, strong) UILabel *privateTitleLb;
@property (nonatomic, strong) UILabel *privateIcon;


@property (nonatomic, strong) UILabel *shopsTitleLb;
@property (nonatomic, strong) UILabel *shopsIcon;

@end

@implementation BrandsView
{
    BOOL _touchBrand;
    BOOL _touchHot;
    BOOL _touchPrivate;
    BOOL _touchShops;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutIMG];
    }
    return self;
}

- (void)layoutIMG
{
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = BackCellColor;
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    /////
    _brandsIMG = [UIImageView new];
    _brandsIMG.image = [UIImage imageNamed:@"img_01"];
    _brandsIMG.backgroundColor = DefaultImgBgColor;
    _brandsIMG.contentMode = UIViewContentModeScaleAspectFill;
    _brandsIMG.clipsToBounds = YES;
    bottomView .layer.masksToBounds = YES;
    bottomView .layer.cornerRadius = 2; //圆角（圆形）
    [bottomView addSubview:_brandsIMG];
    [_brandsIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(top_padding));
        make.left.equalTo(@(left_padding));
        make.width.equalTo(@(brandImg_W));
        make.height.equalTo(@(brandImg_H));
    }];
    
    _brandTitleLb = [UILabel new];
    _brandTitleLb.text = @"品牌街";
    _brandTitleLb.font = [UIFont systemFontOfSize:brands_title_font];
    _brandTitleLb.textColor = [UIColor colorWithHex:0x333333];
    [_brandsIMG addSubview:_brandTitleLb];
    [_brandTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(branchTitle_top_padding));
        make.left.equalTo(@(branchTitle_left_padding));
        make.right.equalTo(@(-branchTitle_left_padding));
    }];
    
    _brandInfoLb = [UILabel new];
    _brandInfoLb.text = @"优质品牌服饰";
    _brandInfoLb.font = [UIFont systemFontOfSize:brands_info_font];
    _brandInfoLb.textColor = [UIColor colorWithHex:0x909090];
    [_brandsIMG addSubview:_brandInfoLb];
    [_brandInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_brandTitleLb.mas_bottom).with.offset(4*rating);
        make.left.equalTo(@(branchTitle_left_padding));
        make.right.equalTo(@(-branchTitle_left_padding));
    }];
    
    //////
    _hotIMG = [UIImageView new];
    _hotIMG.image = [UIImage imageNamed:@"img_02"];
    _hotIMG.backgroundColor = DefaultImgBgColor;
//    _hotIMG.contentMode = UIViewContentModeBottomLeft;
    _hotIMG.clipsToBounds = YES;
    _hotIMG.layer.masksToBounds = YES;
    _hotIMG.layer.cornerRadius = 2; //圆角（圆形）
    [self addSubview:_hotIMG];
    [_hotIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(top_padding));
        make.left.equalTo(_brandsIMG.mas_right).with.offset(img_padding);
        make.width.equalTo(@(hot_W));
        make.height.equalTo(@(hot_H));
    }];
    
    _hotTitleLb = [UILabel new];
    _hotTitleLb.text = @"爆款女装";
    _hotTitleLb.font = [UIFont systemFontOfSize:hot_title_font];
    _hotTitleLb.textColor = [UIColor colorWithHex:0x333333];
    [_hotIMG addSubview:_hotTitleLb];
    [_hotTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(hotTitle_top_padding));
        make.left.equalTo(@(hotTittle_left_padding));
        make.right.equalTo(@(-hotTittle_left_padding));
    }];
    
    _hotInfoLb = [UILabel new];
    _hotInfoLb.text = @"热卖优惠";
    _hotInfoLb.font = [UIFont systemFontOfSize:hot_info_font];
    _hotInfoLb.textColor = [UIColor colorWithHex:0x8c8c8c];
    [_hotIMG addSubview:_hotInfoLb];
    [_hotInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_brandTitleLb.mas_bottom).with.offset(4*rating);
        make.left.equalTo(@(hotTittle_left_padding));
        make.right.equalTo(@(-hotTittle_left_padding));
    }];
    
    ////
    /*
    _privateIMG = [UIImageView new];
    _privateIMG.backgroundColor = DefaultImgBgColor;
    _privateIMG.contentMode = UIViewContentModeScaleAspectFill;
    _privateIMG.clipsToBounds = YES;
    _privateIMG.layer.masksToBounds = YES;
   _privateIMG.layer.cornerRadius = 2; //圆角（圆形）
    [self addSubview:_privateIMG];
    [_privateIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotIMG.mas_bottom).with.offset(img_padding);
        make.left.equalTo(_brandsIMG.mas_right).with.offset(img_padding);
        make.width.equalTo(@(private_W));
        make.height.equalTo(@(private_H));
    }];
    
    _privateTitleLb = [UILabel new];
    _privateTitleLb.text = @"私人\n订制";
    _privateTitleLb.numberOfLines = 2;
    _privateTitleLb.lineBreakMode = NSLineBreakByWordWrapping;
    _privateTitleLb.font = [UIFont systemFontOfSize:private_title_font];
    _privateTitleLb.textColor = [UIColor colorWithHex:0x333333];
    [_privateIMG addSubview:_privateTitleLb];
    [_privateTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(privateTitle_top_padding));
        make.left.equalTo(@(privateTitle_left_padding));
        make.right.equalTo(_privateIMG.mas_right).with.offset(-privateTitle_left_padding);
    }];
    
    _privateIcon = [UILabel new];
    _privateIcon.text = @"HOT";
    _privateIcon.textAlignment = NSTextAlignmentCenter;
    _privateIcon.font = [UIFont systemFontOfSize:icon_font];
    _privateIcon.textColor = ThemeColor;
    [_privateIcon handleCornerRadiusWithRadius:4];
    [_privateIcon handleBoardWidth:1 andBorderColor:ThemeColor];
    [_privateIMG addSubview:_privateIcon];
    [_privateIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(privateTitle_left_padding));
        make.width.equalTo(@(24));
        make.height.equalTo(@(9));
        make.centerY.equalTo(_privateIMG);
    }];
    
    */
    /////
    _shopsIMG = [UIImageView new];
    _shopsIMG.image = [UIImage imageNamed:@"img_03"];
    _shopsIMG.backgroundColor = DefaultImgBgColor;
//    _shopsIMG.contentMode = UIViewContentModeBottomLeft;
    _shopsIMG.clipsToBounds = YES;
    _shopsIMG.layer.masksToBounds = YES;
    _shopsIMG.layer.cornerRadius = 2; //圆角（圆形）
    [self addSubview:_shopsIMG];
    [_shopsIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotIMG.mas_bottom).with.offset(img_padding);
//        make.left.equalTo(_privateIMG.mas_right).with.offset(img_padding);
        make.left.equalTo(_brandsIMG.mas_right).with.offset(img_padding);
        make.width.equalTo(@(hot_W));
        make.height.equalTo(@(hot_H));
    }];
    
    _shopsTitleLb = [UILabel new];
    _shopsTitleLb.text = @"门店";
    _shopsTitleLb.font = [UIFont systemFontOfSize:shops_title_font];
    _shopsTitleLb.textColor = [UIColor colorWithHex:0x333333];
    [_shopsIMG addSubview:_shopsTitleLb];
    [_shopsTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(privateTitle_top_padding));
        make.left.equalTo(@(privateTitle_left_padding));
        make.right.equalTo(@(-privateTitle_left_padding));
    }];
    
    _shopsIcon = [UILabel new];
    _shopsIcon.text = @"优选好店";
//    _shopsIcon.textAlignment = NSTextAlignmentCenter;
    _shopsIcon.font = [UIFont systemFontOfSize:hot_info_font];
    _shopsIcon.textColor = [UIColor colorWithHex:0x8c8c8c];
//    [_shopsIcon handleCornerRadiusWithRadius:4];
//    [_shopsIcon handleBoardWidth:1 andBorderColor:ThemeColor];
    [_shopsIMG addSubview:_shopsIcon];
    [_shopsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopsTitleLb.mas_bottom).with.offset(4*rating);
        make.left.equalTo(@(hotTittle_left_padding));
        make.right.equalTo(@(-hotTittle_left_padding));
    }];
}


#pragma mark --- touch handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _touchBrand = NO;
    _touchHot = NO;
    _touchPrivate = NO;
    _touchShops = NO;
    UITouch* t = [touches anyObject];
    CGPoint p1 = [t locationInView:self.brandsIMG];
    CGPoint p2 = [t locationInView:self.hotIMG];
    CGPoint p3 = [t locationInView:self.privateIMG];
    CGPoint p4 = [t locationInView:self.shopsIMG];
    if (CGRectContainsPoint(self.brandsIMG.bounds, p1)) {
        _touchBrand = YES;
    } else if (CGRectContainsPoint(self.hotIMG.bounds, p2)) {
        _touchHot = YES;
    } else if (CGRectContainsPoint(self.privateIMG.bounds, p3)) {
        _touchPrivate = YES;
    } else if (CGRectContainsPoint(self.shopsIMG.bounds, p4)) {
        _touchShops = YES;
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchBrand) {
        if (_delegate && [_delegate respondsToSelector:@selector(clickIMGWithTags:)]) {
            [_delegate clickIMGWithTags:HomeBrandsTypeBrand];
        }
    } else if (_touchHot) {
        if (_delegate && [_delegate respondsToSelector:@selector(clickIMGWithTags:)]) {
            [_delegate clickIMGWithTags:HomeBrandsTypeHot];
        }
    } else if (_touchPrivate) {
        if (_delegate && [_delegate respondsToSelector:@selector(clickIMGWithTags:)]) {
            [_delegate clickIMGWithTags:HomeBrandsTypePrivate];
        }
    } else if (_touchShops) {
        if (_delegate && [_delegate respondsToSelector:@selector(clickIMGWithTags:)]) {
            [_delegate clickIMGWithTags:HomeBrandsTypeShops];
        }
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_touchBrand || !_touchHot ||!_touchPrivate || !_touchShops) {
        [super touchesCancelled:touches withEvent:event];
    }
}


@end
