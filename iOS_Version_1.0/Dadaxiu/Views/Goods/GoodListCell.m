//
//  GoodListCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GoodListCell.h"

#define IMG_W CGRectGetWidth(self.contentView.frame)
#define IMG_H IMG_W

#define IMG_title_padding 8*kScreen_Width/375
#define title_price_padding 12*kScreen_Width/375
#define price_bottom_padding 12*kScreen_Width/375

@interface GoodListCell ()

@property (nonatomic, strong) UIImageView *IMG;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *countLb;
@property (nonatomic, strong) UIImageView *countIMG;

@end

@implementation GoodListCell

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
    GoodListCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.backgroundColor = [UIColor whiteColor];
    return item;
}

- (void)layoutSubs
{
    _IMG = [UIImageView new];
    _IMG.backgroundColor = DefaultImgBgColor;
    [_IMG handleCornerRadiusWithRadius:5];
    [self.contentView addSubview:_IMG];
    
    [_IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(IMG_H));
    }];
    
    _titleLb = [UILabel new];
    _titleLb.text = @"甜美少女风时尚迷人潮流";
    _titleLb.font = [UIFont systemFontOfSize:12*kScreen_Width/375];
    _titleLb.textColor = [UIColor colorWithHex:0x353434];
    [self.contentView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_IMG.mas_bottom).with.offset(IMG_title_padding);
        make.left.equalTo(@(0));
        make.height.equalTo(@(13*kScreen_Width/375));
        make.right.equalTo(@(0));
    }];
    
    _priceLb = [UILabel new];
    _priceLb.text = @"¥169.40";
    _priceLb.font = [UIFont systemFontOfSize:12*kScreen_Width/375];
    _priceLb.textColor = ThemeColor;
    [self.contentView addSubview:_priceLb];
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLb.mas_bottom).with.offset(title_price_padding);
        make.left.equalTo(@(0));
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-price_bottom_padding);
    }];
    
    _countLb = [UILabel new];
    _countLb.text = @"2156";
    _countLb.font = [UIFont systemFontOfSize:12*kScreen_Width/375];
    _countLb.textColor = [UIColor colorWithHex:0xa6a6a6];
    [self.contentView addSubview:_countLb];
    [_countLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLb.mas_right).with.offset(4*kScreen_Width/375);
        make.height.equalTo(@(12*kScreen_Width/375));
        make.centerY.equalTo(_priceLb);
    }];
    
    _countIMG  = [UIImageView new];
    _countIMG.contentMode = UIViewContentModeScaleAspectFit;
    _countIMG.image = [GoodListCell goodsCollect];
    [self.contentView addSubview:_countIMG];
    
    [_countIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_countLb.mas_right).with.offset(5*kScreen_Width/375);
        make.right.equalTo(@(0));
        make.width.equalTo(@(9*kScreen_Width/375));
        make.height.equalTo(@(9*kScreen_Width/375));
        make.centerY.equalTo(_countLb);
    }];
}

- (void)setGoodType:(GoodsThirdClassrifyType)goodType
{
    _goodType = goodType;
    
    if (_goodType == GoodsThirdClassrifyTypeDIY) {
        _countIMG.image = [GoodListCell goodsDIY];
    } else if (_goodType == GoodsThirdClassrifyTypeNormal) {
        _countIMG.image = [GoodListCell goodsCollect];
    } else if (_goodType == GoodsThirdClassrifyTypeFittingroom) {
        _countIMG.image = [GoodListCell goodsfashion];
    }
}

- (void)setGoodsItem:(DDXGoodsModel *)goodsItem
{
    [_IMG loadPicture:[NSURL URLWithString:goodsItem.imageUrl]];
    _titleLb.text = goodsItem.goodsName;
    _priceLb.text = [NSString stringWithFormat:@"¥%ld", (long)goodsItem.shopPrice];
    _countLb.text = [NSString stringWithFormat:@"%ld", (long)goodsItem.goodsInventory];
}

#pragma MARK - image init

static UIImage *_goodsCollect;
+ (UIImage *)goodsCollect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _goodsCollect = [UIImage imageNamed:@"goods_collect"];
    });
    return _goodsCollect;
}

static UIImage *_goodsfashion;
+ (UIImage *)goodsfashion
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _goodsfashion = [UIImage imageNamed:@"goods_fashion"];
    });
    return _goodsfashion;
}

static UIImage *_goodsDIY;
+ (UIImage *)goodsDIY
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _goodsDIY = [UIImage imageNamed:@"goods_DIY"];
    });
    return _goodsDIY;
}

@end
