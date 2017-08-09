//
//  GuessLikeCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/3.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GuessLikeCell.h"
#import "UIColorHF.h"
#import "UIImageView+Comment.h"

#define kImage_W CGRectGetWidth(self.contentView.frame)
#define kImage_H kImage_W

#define img_title_padding 12*kImage_W/170
#define title_price_padding 11*kImage_W/170

#define title_font 13*kImage_W/170
#define price_font 15*kImage_W/170

#define cartsIcon_W 30*kImage_W/170
#define cartsIcon_H 15*kImage_W/170

@interface GuessLikeCell ()

@property (nonatomic, strong) UIImageView *goodsIMG;
@property (nonatomic, strong) UILabel *goodsNameLb;
@property (nonatomic, strong) UILabel *goodPriceLb;
@property (nonatomic, strong) UIButton *cartsBtn;

@end

@implementation GuessLikeCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self layoutSubs];
    }
    return self;
}
+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    GuessLikeCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.contentView.backgroundColor = [UIColor whiteColor];
    return item;
}

- (void)layoutSubs
{
    _goodsIMG = [UIImageView new];
    _goodsIMG.image = [UIImage imageWithColor:DefaultImgBgColor];
    _goodsIMG.backgroundColor = ThemeColor;
    [_goodsIMG handleCornerRadiusWithRadius:5];
    [self.contentView addSubview:_goodsIMG];
    
    [_goodsIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.width.equalTo(@(kImage_W));
        make.height.equalTo(@(kImage_H));
    }];
    
    _goodsNameLb = [UILabel new];
    _goodsNameLb.text = @"甜美少女风时尚迷人潮流";
    _goodsNameLb.font = [UIFont systemFontOfSize:title_font];
    _goodsNameLb.textColor = [UIColor colorWithHex:0x3f3f3f]; 
    [self.contentView addSubview:_goodsNameLb];
    [_goodsNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsIMG.mas_bottom).with.offset(img_title_padding);
        make.left.equalTo(@(0));
        make.height.equalTo(@(17*(kScreen_Height/667)));
        make.right.equalTo(@(0));
    }];
    
    _goodPriceLb = [UILabel new];
    _goodPriceLb.text = @"¥169.40";
    _goodPriceLb.font = [UIFont systemFontOfSize:price_font];
    _goodPriceLb.textColor = ThemeColor;
    [self.contentView addSubview:_goodPriceLb];
    [_goodPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsNameLb.mas_bottom).with.offset(title_price_padding);
        make.left.equalTo(@(0));
        make.height.equalTo(@(15*(kScreen_Height/667)));
    }];
    
    _cartsBtn = [UIButton new];
    _cartsBtn.enabled = NO;
    _cartsBtn.hidden = YES;
    [_cartsBtn setImage:[UIImage imageNamed:@"ico_buy"] forState:UIControlStateNormal];
    [self.contentView addSubview:_cartsBtn];
    [_cartsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.width.equalTo(@(cartsIcon_W));
        make.height.equalTo(@(cartsIcon_H));
        make.centerY.equalTo(_goodPriceLb);
    }];
    [_cartsBtn addTarget:self action:@selector(shopCartAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)shopCartAction:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(pushGoodsToCart)]) {
        [_delegate pushGoodsToCart];
    }
}

- (void)setLikeModel:(DDXLikeGoodsModel *)likeModel
{
    [_goodsIMG loadPicture:[NSURL URLWithString:likeModel.imageUrl]];
    _goodsNameLb.text = likeModel.goodsName;
    _goodPriceLb.text = [NSString stringWithFormat:@"¥%.2f", likeModel.shopPrice];
}

@end
