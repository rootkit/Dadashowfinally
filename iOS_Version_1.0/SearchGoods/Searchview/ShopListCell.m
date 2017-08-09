//
//  ShopListCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ShopListCell.h"
#import "UIImageView+WebCache.h"
#define IMG_W CGRectGetWidth(self.contentView.frame)
#define IMG_H IMG_W

#define IMG_title_padding 8*kScreen_Width/375
#define title_price_padding 12*kScreen_Width/375
#define price_bottom_padding 12*kScreen_Width/375


@interface ShopListCell()
@property (nonatomic, strong) UIImageView *IMG;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *priceLb;

@end
@implementation ShopListCell

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
    ShopListCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.backgroundColor = [UIColor whiteColor];
    return item;
}

- (void)layoutSubs
{
    _IMG = [UIImageView new];
    [self.contentView addSubview:_IMG];
       [_IMG handleCornerRadiusWithRadius:5];
    _IMG.backgroundColor=DefaultImgBgColor;
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
    
}

-(void)setListmodel:(DDXSearchModel *)listmodel{
    
    _listmodel=listmodel;
    if (listmodel.imageUrl.length>0) {
        
    [_IMG sd_setImageWithURL:[NSURL URLWithString:listmodel.imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
    
    }
    if (listmodel.goodsName.length>0) {
        _titleLb.text = listmodel.goodsName;
    }else{
         _titleLb.text = @"未知";
    }
    if (listmodel.shopPrice.length>0) {
        _priceLb.text =listmodel.shopPrice;
    }else{
        _priceLb.text = @"未知";
    }
}

@end
